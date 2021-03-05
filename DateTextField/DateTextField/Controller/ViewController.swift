//
//  ViewController.swift
//  DateTextField
//
//  Created by Dang Duy Cuong on 9/18/20.
//  Copyright © 2020 Dang Duy Cuong. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var listDataCorona = [String]()
    var suggestList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CoronaCellCell.nib(), forCellReuseIdentifier: CoronaCellCell.identifier())
        searchBar.delegate = self
        
        let rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(callAPI))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if suggestList.count == 0 {
            callAPI()
        }
    }
    
    @objc func callAPI() {
        showLoading()
        let link = "https://who-covid-19-data.p.rapidapi.com/api/data/names"
        //        let link = "https://who-covid-19-data.p.rapidapi.com/api/data/dates"
        let headers = [
            "x-rapidapi-key": "b266514becmsh63278b22c117acfp12ef2cjsn7a142a5dffa4",
            "x-rapidapi-host": "who-covid-19-data.p.rapidapi.com"
        ]
        
        BaseRouter.shared.getData(urlString: link, headers: headers, method: .get, completion: { (data: DataModel) in
            self.hideLoading()
            if let names = data.names {
                self.listDataCorona = names
            }
            
            if let names = data.reportDates {
                self.listDataCorona = names
            }
            self.suggestList = self.listDataCorona
            self.tableView.reloadData()
        })
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suggestList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoronaCellCell.identifier(), for: indexPath) as! CoronaCellCell
        cell.dataLabel.text = "\(indexPath.row + 1). " + suggestList[indexPath.row]
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        title = ""
        let vc = Storyboard.Main.detailViewController()
        vc.name = suggestList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UISearchBarDelegate {
    func filterSuggest() {
        if let text = searchBar.text {
            if text == "" {
                suggestList = listDataCorona
            } else {
                suggestList = listDataCorona.filter { (data: String) in
                    if data.lowercased().range(of: text.lowercased()) != nil {
                        return true
                    }
                    return false
                }
            }
        }
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterSuggest()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}



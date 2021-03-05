//
//  DetailViewController.swift
//  DateTextField
//
//  Created by Dang Duy Cuong on 3/5/21.
//  Copyright © 2021 Dang Duy Cuong. All rights reserved.
//

import UIKit
import SwiftyJSON

class DetailViewController: BaseViewController {
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBOutlet weak var confirmedLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var pageLabel: UILabel!
    
    var params = [URLQueryItem]()
    
    var date: String = ""
    var name: String = ""
    
    var listData = [DailyReportByCountryNameModel]()
    var listProvince = [Provinces]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
        title = name
        tableView.register(CountryCoronaCell.nib(), forCellReuseIdentifier: CountryCoronaCell.identifier())
        
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        
        dateformatter.dateFormat = "yyyy-MM-dd"
        self.date = dateformatter.string(from: date)
        dateformatter.dateFormat = "dd-MM-yyyy"
        dateTextField.text = dateformatter.string(from: date)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        
        callAPI()
    }
    
    func callAPI() {
        showLoading()
        params = [
            URLQueryItem(name: "date", value: date),
            URLQueryItem(name: "name", value: name)
        ]
        let headers = [
            "x-rapidapi-key": "b266514becmsh63278b22c117acfp12ef2cjsn7a142a5dffa4",
            "x-rapidapi-host": "covid-19-data.p.rapidapi.com"
        ]
        let link = "https://covid-19-data.p.rapidapi.com/report/country/name"
        BaseRouter.shared.getData(urlString: link, params: params, headers: headers, method: .get, completion: { (data: JSON) in
            self.hideLoading()
            if let message = data["message"].string {
                self.confirmedLabel.text = message
            }
            let array = [nnn](byJSON: data)
            guard array.count > 0 else {
                return
            }
            if let provinces = array[0].provinces {
                self.listProvince = provinces
                self.pageLabel.text = "\(provinces.count)"
                self.tableView.reloadData()
            }
        })
    }
    
    //2
    @objc func tapDone() {
        if let datePicker = dateTextField.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .medium // 2-3
            //            dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateformatter.dateFormat = "yyyy-MM-dd"
            //            dateformatter.dateStyle = .full
            date = dateformatter.string(from: datePicker.date)
            dateformatter.dateFormat = "dd-MM-yyyy"
            dateTextField.text = dateformatter.string(from: datePicker.date) //2-4
            
        }
        dateTextField.resignFirstResponder() // 2-5
        callAPI()
    }
    
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listProvince.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryCoronaCell.identifier(), for: indexPath) as! CountryCoronaCell
        cell.data = listProvince[indexPath.row]
        cell.fillData()
        
        return cell
    }
    
}



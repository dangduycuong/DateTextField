//
//  CountryCoronaCell.swift
//  DateTextField
//
//  Created by Dang Duy Cuong on 3/5/21.
//  Copyright © 2021 Dang Duy Cuong. All rights reserved.
//

import UIKit

class CountryCoronaCell: BaseTableViewCell {
    @IBOutlet weak var provinceTextView: UITextView!
    @IBOutlet weak var confirmedTextView: UITextView!
    
    @IBOutlet weak var activeTextView: UITextView!
    @IBOutlet weak var recoveredTextView: UITextView!
    @IBOutlet weak var deathsTextView: UITextView!
    
    var data = Provinces()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillData() {
        provinceTextView.text = data.province
        confirmedTextView.text = data.confirmed
        activeTextView.text = data.active
        recoveredTextView.text = data.recovered
        deathsTextView.text = data.deaths
    }
    
}


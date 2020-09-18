//
//  ViewController.swift
//  DateTextField
//
//  Created by Dang Duy Cuong on 9/18/20.
//  Copyright © 2020 Dang Duy Cuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.myTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone)) //1
    }
    
    //2
    @objc func tapDone() {
        if let datePicker = self.myTextField.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .medium // 2-3
//            dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateformatter.dateFormat = "dd-MM-yyyy"
//            dateformatter.dateStyle = .full
            myTextField.text = dateformatter.string(from: datePicker.date) //2-4

        }
        self.myTextField.resignFirstResponder() // 2-5
    }

}



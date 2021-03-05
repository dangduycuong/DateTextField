//
//  Storyboard.swift
//  DateTextField
//
//  Created by Dang Duy Cuong on 3/5/21.
//  Copyright © 2021 Dang Duy Cuong. All rights reserved.
//

import UIKit

struct Storyboard {
    
}

extension Storyboard {
    
    struct Main {
        static let manager = UIStoryboard(name: "Main", bundle: nil)
        
        static func detailViewController() -> DetailViewController {
            return manager.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        }
        
    }
}

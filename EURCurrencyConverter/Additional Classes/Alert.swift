//
//  File.swift
//  EURCurrencyConverter
//
//  Created by Ulad Daratsiuk-Demchuk on 2018-01-22.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit


class Alert {
    
    class func showBasic(title: String, msg: String, vc: UIViewController) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert )
        alert.addAction(UIAlertAction(title: "ok", style: .default , handler: nil))
        vc.present(alert, animated: true)
    }
    
    
    
    
    
    
}

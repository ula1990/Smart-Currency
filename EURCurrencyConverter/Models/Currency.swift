//
//  Currency.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 6/5/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class Currency: NSObject {
    var name: String?
    var rate: Double?

    
    init(name: String, rate: Double){
        self.name = name
        self.rate = rate
    }
    
}

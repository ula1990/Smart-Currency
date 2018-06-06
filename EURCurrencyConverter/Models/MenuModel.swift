//
//  MenuModel.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 6/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class MenuModel {
    var title: String?
    var icon: UIImage?
    var viewController: UIViewController?
    
    init(title: String?, icon: UIImage?, viewController: UIViewController?){
        self.title = title
        self.icon = icon
        self.viewController = viewController
    }
}

//
//  RatesCell.swift
//  EURCurrencyConverter
//
//  Created by Ulad Daratsiuk-Demchuk on 2018-01-19.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class AmountCell: UITableViewCell {


    @IBOutlet weak var newLabel: UILabel!
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var flagImage: UIImageView!

 //UPDATE CURRENCY IMAGE
    func flagOfCurrency(image: String){
        
        self.flagImage.image = UIImage(named: image)
        self.flagImage.layer.shadowOpacity = 2
        
    }
    
    
    
 
    
    
    
}

//
//  RatesCell.swift
//  EURCurrencyConverter
//
//  Created by Ulad Daratsiuk-Demchuk on 2018-01-22.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class RatesCell: UITableViewCell {

    @IBOutlet weak var nameOfTheRates: UILabel!
    @IBOutlet weak var rateOfTheCurrency: UILabel!
    @IBOutlet weak var differenceLabel: UILabel!
    
    func labelName(selectedByUserCurrency: String, ratesNames: String){
        nameOfTheRates.text = selectedByUserCurrency + "/" + ratesNames
        
    }
    func changeColorForLabel(){
    if differenceLabel.text!.range(of:"-") != nil {
    differenceLabel.backgroundColor = UIColor.red.withAlphaComponent(0.8)

         
    }else{
        differenceLabel.backgroundColor = UIColor.init(red: 0.1, green: 0.7, blue: 0.1, alpha: 0.8)
 
        
        
    }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    

}

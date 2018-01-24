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
    differenceLabel.backgroundColor = UIColor.red.withAlphaComponent(0.6)

         
    }else{
        differenceLabel.backgroundColor = UIColor.green.withAlphaComponent(0.6)
 
        
        
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

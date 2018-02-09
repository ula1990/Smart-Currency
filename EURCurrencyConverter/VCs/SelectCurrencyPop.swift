//
//  SelectCurrencyPop.swift
//  EURCurrencyConverter
//
//  Created by Ulad Daratsiuk-Demchuk on 2018-01-19.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

protocol transferSelectedRateDelegate{
    func rateReceived(selectedCurrency: String )
}

class SelectCurrencyPop: UIViewController {
    
    var currencyNames = ["EUR", "USD", "CAD", "GBP", "RUB","CNY", "PLN", "THB", "BGN", "AUD", "SEK", "ILS", "BRL", "DKK", "CHF", "MXN", "HRK", "RON", "TRY", "SGD", "NOK", "HUF", "NZD", "MYR", "IDR", "KRW", "JPY", "INR", "PHP", "CZK", "HKD", "ZAR"]
    var selectedCurrency: String!
    var selectionDelegate: transferSelectedRateDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveData(_ sender: Any) {
            dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
}

extension SelectCurrencyPop: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    
        return currencyNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            selectionDelegate?.rateReceived(selectedCurrency: currencyNames[row])
    }
    
}




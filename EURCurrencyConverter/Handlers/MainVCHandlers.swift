//
//  MainVCHandlers.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 6/5/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension MainVC {
    @objc public func getData(nameOfCurrency: String?){
        receivedCurrencies.removeAll()
        let url = URL(string: "https://exchangeratesapi.io/api/latest?base=" + nameOfCurrency!)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //FOR FASTER WORK OF PICKERVIEW
            DispatchQueue.main.async {
                if error != nil{
                    Alert.showBasic(title: "Offline Mode", msg: "Please check connection and update the rates,in offline mode available only EUR", vc: self)
                    self.receivedCurrencies = self.createOfflineArray()
                    self.handleInput()
                    self.currenciesTable.reloadData()
                    self.selectedCurrencyActual = "EUR"
                    self.selectedCurrencyLabel.text = "Current: " + self.selectedCurrencyActual
                }
                else{
                    if let content = data{
                        do{
                            let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            if let date = myJson["date"] as? NSString{
                                self.lastUpdateDateLabel.text = "Last update: " + (date as String)
                            }
                            if let rates = myJson["rates"] as? NSDictionary{
                                for (key,value ) in rates{
                                    let currency = Currency(name: (key as? String)!, rate: round(((value as? Double)!)*100)/100)
                                    print("name: " + (key as? String)! + ", rate:" + String(round(((value as? Double)!)*100)/100))
                                    self.receivedCurrencies.append(currency)
                                    self.handleInput()
                                }
                            }
                        }
                        catch{
                            self.getData(nameOfCurrency: self.selectedCurrencyLabel.text! )
                        }
                    }
                }
                self.currenciesTable.reloadData()
    
            }
        }
        task.resume()
    }

    @objc public func handleUpdateCurrencies(){
        getData(nameOfCurrency: selectedCurrencyActual)
    }
    
    @objc public func handleSelectCurrency(){
        let vc = SelectCurrencyPop()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    @objc public func handleInput(){
        if inputTextField.text?.isEmpty == true {
            print(Error.self)
            currentAmount.removeAll()
            currentAmount = receivedCurrencies.map{ $0.rate! * 0.0 }
            currenciesTable.reloadData()
        }else{
            currentAmount.removeAll()
            currentAmount = receivedCurrencies.map{ $0.rate! * Double(inputTextField.text!)! }
            currenciesTable.reloadData()
        }
    }
    
    @objc public func createOfflineArray()->[Currency]{
        var array: [Currency] = []
        let item1 = Currency(name: "CNY", rate:7.48)
        let item2 = Currency(name: "PLN", rate:4.29)
        let item3 = Currency(name: "THB", rate:37.34)
        let item4 = Currency(name: "BGN", rate:1.96)
        let item5 = Currency(name: "AUD", rate:1.53)
        let item6 = Currency(name: "SEK", rate:10.25)
        let item7 = Currency(name: "ILS", rate:4.17)
        let item8 = Currency(name: "BRL", rate:4.39)
        let item9 = Currency(name: "DKK", rate:7.44)
        let item10 = Currency(name: "GBP", rate:0.87)
        let item11 = Currency(name: "RUB", rate:72.82)
        let item12 = Currency(name: "CHF", rate:1.15)
        let item13 = Currency(name: "ISK", rate:123.5)
        let item14 = Currency(name: "HRK", rate:7.38)
        let item15 = Currency(name: "MXN", rate:23.8)
        let item16 = Currency(name: "RON", rate:4.65)
        let item17 = Currency(name: "SGD", rate:1.56)
        let item18 = Currency(name: "TRY", rate:5.39)
        let item19 = Currency(name: "NOK", rate:9.5)
        let item20 = Currency(name: "HUF", rate:318.68)
        let item21 = Currency(name: "NZD", rate:1.66)
        let item22 = Currency(name: "USD", rate:1.17)
        let item23 = Currency(name: "MYR", rate:4.65)
        let item24 = Currency(name: "IDR", rate:16208.4)
        let item25 = Currency(name: "KRW", rate:1250.33)
        let item26 = Currency(name: "JPY", rate:128.08)
        let item27 = Currency(name: "INR", rate:78.4)
        let item28 = Currency(name: "PHP", rate:61.22)
        let item29 = Currency(name: "CZK", rate:25.65)
        let item30 = Currency(name: "HKD", rate:9.16)
        let item31 = Currency(name: "ZAR", rate:14.82)
        let item32 = Currency(name: "CAD", rate:1.52)
        
        array.append(item1)
        array.append(item2)
        array.append(item3)
        array.append(item4)
        array.append(item5)
        array.append(item6)
        array.append(item7)
        array.append(item8)
        array.append(item9)
        array.append(item10)
        array.append(item11)
        array.append(item12)
        array.append(item13)
        array.append(item14)
        array.append(item15)
        array.append(item16)
        array.append(item17)
        array.append(item18)
        array.append(item19)
        array.append(item20)
        array.append(item21)
        array.append(item22)
        array.append(item23)
        array.append(item24)
        array.append(item25)
        array.append(item26)
        array.append(item27)
        array.append(item28)
        array.append(item29)
        array.append(item30)
        array.append(item31)
        array.append(item32)

        return array
    }
    
}

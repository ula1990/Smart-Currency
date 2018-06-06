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
                    Alert.showBasic(title: "No Internet", msg: "Please check connection and update the rates", vc: self)
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
    
    
}

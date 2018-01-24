//
//  RatesVC.swift
//  EURCurrencyConverter
//
//  Created by Ulad Daratsiuk-Demchuk on 2018-01-22.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class RatesVC: UIViewController {
    
    var receivedCurrencyNames: [String] = []
    var recerivedCurrencyRates: [Double] = []
    var oldCurrencyNames: [String] = []
    var oldCurrencyRates: [Double] = []
    var differenceInRates: [Double] = []
    var currencySelected: String?
    var receivedRate: String!
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var tableViewRates: UITableView!
    
    //GET DATE FROM YESTERDAY
    
    func yesterdayDate()  -> String {
        
        let yesterday = Calendar.current.date(byAdding: .day, value: -2, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: yesterday!)
        return date
    }
   
    
    //DOWNLOAD FRESH RATES
    
    func getData(nameOfCurrency: String?){
        
        receivedCurrencyNames.removeAll()
        recerivedCurrencyRates.removeAll()
        let url = URL(string: "https://api.fixer.io/latest?base=" + nameOfCurrency!)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //FOR FASTER WORK
            DispatchQueue.main.async {
                if error != nil
                {
                    Alert.showBasic(title: "No Internet", msg: "Please check connection", vc: self)
                }
                else{
                    if let content = data
                        
                    {
                        do{
                            let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            
                            
                            if let rates = myJson["rates"] as? NSDictionary
                            {
                                
                                for (key,value ) in rates
                                {
                                    self.receivedCurrencyNames.append((key as? String)!)
                                    self.recerivedCurrencyRates.append((value as? Double)!)
                                   
                                }
                                ///eror handling
                            }
                        }
                        catch{
                            Alert.showBasic(title: "Can't download rates", msg: "Please check connection", vc: self)
                        }
                    }
                }
                self.tableViewRates.reloadData()
            }
        }
        task.resume()
    }
    
    
    
    func getOldRates(selectedCurrency: String?, date: String? ){
        oldCurrencyNames.removeAll()
        oldCurrencyRates.removeAll()
        let url = URL(string: "https://api.fixer.io/" + date! + "?base=" + selectedCurrency!)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
        
            //FOR FASTER WORK
            DispatchQueue.main.async {
                if error != nil
                {
                    Alert.showBasic(title: "No Internet", msg: "Please check connection", vc: self)
                }
                else{
                    if let content = data
                        
                    {
                        do{
                            let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            
                            
                            if let rates = myJson["rates"] as? NSDictionary
                            {
                                
                                for (key,value ) in rates
                                {
                                    self.oldCurrencyNames.append((key as? String)!)
                                    self.oldCurrencyRates.append((value as? Double)!)
                                    
                                }
                                 self.differenceInRates = self.getDifferenceInRates(freshRates: self.recerivedCurrencyRates, oldRates: self.oldCurrencyRates)
                                print(self.differenceInRates)
                            }
                        }
                        catch{
                            Alert.showBasic(title: "Can't download rates", msg: "Please check connection", vc: self)
                        }
                    }
                }
                self.tableViewRates.reloadData()
            }
        }
        task.resume()
    }
    
    //CHECK DIFFERENCE BETWEEN OLD RATES AND NEW
    func  getDifferenceInRates(freshRates: [Double], oldRates: [Double]) -> [Double]{
        
        let difference: [Double] = zip(freshRates, oldRates).map({ $0.0 - $0.1 })
        return difference
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(nameOfCurrency: currencySelected)
        getOldRates(selectedCurrency: currencySelected, date: yesterdayDate())
       
        
        tableViewRates.delegate = self
        tableViewRates.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension RatesVC: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedCurrencyNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = receivedCurrencyNames[indexPath.row]
        let rates = recerivedCurrencyRates[indexPath.row]
        let difference = differenceInRates[indexPath.row]
        let cell = tableViewRates.dequeueReusableCell(withIdentifier: "RatesCell") as! RatesCell
        cell.labelName(selectedByUserCurrency: currencySelected!, ratesNames: title)
        cell.rateOfTheCurrency.text = String(rates)
        cell.differenceLabel.text = String(Float(difference))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewRates.deselectRow(at: indexPath, animated: true)
    }
}



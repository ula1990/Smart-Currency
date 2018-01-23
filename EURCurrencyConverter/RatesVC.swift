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
    var currencySelected: String?
    var receivedRate: String!
    
    @IBOutlet weak var testLabel: UILabel!
    @IBOutlet weak var tableViewRates: UITableView!
    
   
    
    func getData(nameOfCurrency: String?){
        
        receivedCurrencyNames.removeAll()
        recerivedCurrencyRates.removeAll()
        let url = URL(string: "https://api.fixer.io/latest?base=" + nameOfCurrency!)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //FOR FASTER WORK OF PICKERVIEW
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
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(nameOfCurrency: currencySelected)
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
        let cell = tableViewRates.dequeueReusableCell(withIdentifier: "RatesCell") as! RatesCell
        cell.labelName(selectedByUserCurrency: currencySelected!, ratesNames: title)
        cell.rateOfTheCurrency.text = String(rates)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewRates.deselectRow(at: indexPath, animated: true)
    }
}



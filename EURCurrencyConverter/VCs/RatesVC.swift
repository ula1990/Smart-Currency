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
    var justOnce: Bool = true
    
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
        cleanArrays()
        let url = URL(string: "https://exchangeratesapi.io/api/latest?base=" + nameOfCurrency!)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            //FOR FASTER WORK
            DispatchQueue.main.async {
                if error != nil
                {
                    if  self.justOnce{
                        Alert.showBasic(title: "No Internet", msg: "Please check connection", vc: self)
                        
                        self.justOnce = false
                    }
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
                                    self.recerivedCurrencyRates.append(round(((value as? Double)!)*1000)/1000)
                                }
                            }
                        }
                        catch{
                            if  self.justOnce{
                            Alert.showBasic(title: "Can't download rates", msg: "Please check connection", vc: self)
                            self.justOnce = false
                            
                        }
                        }
                    }
                }
             self.tableViewRates.reloadData() }
        }
        task.resume()
    }
    
    //GET OLD RATES
  func getOld(selectedCurrency: String?, date: String?){
        let urlOld = URL(string: "https://exchangeratesapi.io/api/" + date! + "?base=" + selectedCurrency!)
        let taskOld = URLSession.shared.dataTask(with: urlOld!) { (data, response, error) in
            
            //FOR FASTER WORK
            DispatchQueue.main.async {
                if error != nil
                {
                     if  self.justOnce{
                    Alert.showBasic(title: "No Internet", msg: "Please check connection", vc: self)
                        self.justOnce = false
                        
                    }
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
                                    self.oldCurrencyRates.append(round(((value as? Double)!)*1000)/1000)
                                }
                                self.differenceInRates = self.getDifferenceInRates()
                            }
                            

                            
                        }
                        catch{
                            if  self.justOnce{
                            Alert.showBasic(title: "Can't download rates", msg: "Please check connection", vc: self)
                                self.justOnce = false
                                
                            }
                        }
                    }
                }
            self.tableViewRates.reloadData()
            }
        }
        taskOld.resume()
        
    }

    //CHECK DIFFERENCE BETWEEN OLD RATES AND NEW
    func  getDifferenceInRates() -> [Double]{
            for (freshRate,oldRate) in zip(recerivedCurrencyRates, oldCurrencyRates){
            differenceInRates.append(oldRate - freshRate)}
            return differenceInRates
    }
    //CLEANING
    func cleanArrays(){
        differenceInRates.removeAll()
        oldCurrencyNames.removeAll()
        oldCurrencyRates.removeAll()
        recerivedCurrencyRates.removeAll()
        receivedCurrencyNames.removeAll()
        tableViewRates.reloadData()
    }
    
    //BACK
    
    func back(){
        performSegue(withIdentifier: "noconnection", sender: navigationController)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getOld(selectedCurrency: self.currencySelected, date: yesterdayDate())
        getData(nameOfCurrency: self.currencySelected)
        tableViewRates.delegate = self
        tableViewRates.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
      
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//CONFIGURATIONS OF THE TABLE RATES

extension RatesVC: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            guard recerivedCurrencyRates.count != 0,
            differenceInRates.count != 0,
            receivedCurrencyNames.count != 0
            else {
                self.getOld(selectedCurrency: self.currencySelected, date: yesterdayDate())
                self.differenceInRates = self.getDifferenceInRates()
               
                return 0
        }
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
        cell.changeColorForLabel()
       
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewRates.deselectRow(at: indexPath, animated: true)
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let closeAction = UIContextualAction(style: .normal, title:  "Close", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            let cell = tableView.cellForRow(at: indexPath) as! RatesCell
            UIPasteboard.general.string = cell.rateOfTheCurrency.text!
            
            success(true)
        })
        closeAction.title = "Copy"
        closeAction.backgroundColor = .orange
        
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
}



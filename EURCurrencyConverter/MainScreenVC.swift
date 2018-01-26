//
//  MainScreenVC.swift
//  EURCurrencyConverter
//
//  Created by Ulad Daratsiuk-Demchuk on 2018-01-19.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MainScreenVC: UIViewController {
    enum textFieldInputErrors: Error {
        case emptyField
        case firstNotZero
        case maxCharacters
    }

    //MARK: DECLARE ARRAYS
    
    var receivedRates: [Double] = []
    var receivedTitle: [String] = []
    var currentAmount: [Double] = []
    var selectedCurrencyActual: String = "EUR"
    var dateOfTheUpdate: String?
    var selectedRateforInfo: String?
    
    //CURRENCY FORMAT
    
    let formatter = NumberFormatter()
    

    //ADDED OUTLETS FOR ALL ELEMENTS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var updateRates: UIButton!
    @IBOutlet weak var selectedCurrencyLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    
    
    
    
    @IBAction func selectCurrency(_ sender: UIButton) {
          sender.pulstate()
    }
    
    
    //UPDATE RATES
    @IBAction func updateRates(_ sender: UIButton) {
            sender.flash()
            getData(nameOfCurrency: selectedCurrencyLabel.text)
        
    }
    
    //TEXT FIELD
    @IBAction func inputTextFieldAction(_ sender: Any) {
        do{
            
            try textFieldDidChange(inputTextField)
            
        }catch textFieldInputErrors.emptyField{
            print(Error.self)
        }catch textFieldInputErrors.maxCharacters{
            Alert.showBasic(title: "Max Length", msg: "Maximum amount of numbers in the field is 10", vc: self)
        }catch textFieldInputErrors.firstNotZero{
            Alert.showBasic(title: "Incorrect input", msg: "On the start number can't be 00", vc: self)
        }catch{
            Alert.showBasic(title: "Incorrect input", msg: "Please check the field", vc: self)
        }
   
    } 
    
    //FUNC TO CALCULATE AMOUNT AFTER INPUT
    func calculateAmount(){
        if inputTextField.text?.isEmpty == true {
            print(Error.self)
        }else{
            currentAmount.removeAll()
            currentAmount = receivedRates.map{ $0 * Double(inputTextField.text!)! }
            
        }
        
    }
    
    
    //MONITOR CHAGES IN TEXTFIELD
    @objc func textFieldDidChange(_ textField: UITextField) throws {
        tableView.reloadData()
        calculateAmount()
    
    }
    
    //MARK: GET DATA FROM API
    func getData(nameOfCurrency: String?){
        
        receivedRates.removeAll()
        receivedTitle.removeAll()
        let url = URL(string: "https://api.fixer.io/latest?base=" + nameOfCurrency!)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in       
            //FOR FASTER WORK OF PICKERVIEW
            DispatchQueue.main.async {
                if error != nil
                {
                    Alert.showBasic(title: "No Internet", msg: "Please check connection and update the rates", vc: self)
                }
                else{
                    if let content = data
                        
                    {
                        do{
                            let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                            
                            if let date = myJson["date"] as? NSString
                            {
                                self.lastUpdateLabel.text = "Last update: " + (date as String)
                                
                            }
                            
                            
                            if let rates = myJson["rates"] as? NSDictionary
                            {
                                
                                for (key,value ) in rates
                                {
                                    self.receivedTitle.append((key as? String)!)
                                    self.receivedRates.append((value as? Double)!)
                                    self.calculateAmount()
                                }
                                ///eror handling
                            }
                        }
                        catch{
                           // Alert.showBasic(title: "Can't download rates", msg: "Please check connection", vc: self)
                            self.getData(nameOfCurrency: self.selectedCurrencyLabel.text! )
                        }
                    }
                }
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        selectedCurrencyLabel.text = "EUR"
        getData(nameOfCurrency: selectedCurrencyLabel.text)
        selectedCurrencyLabel.text = selectedCurrencyActual
        inputTextField.text = "0"
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .allEditingEvents)
        inputTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
     
        selectButton.layer.cornerRadius = 10
        updateRates.layer.cornerRadius = 10
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()


       
    }
    
    
    
    //ABOUT BUTTON
    @IBAction func aboutButton(_ sender: Any) {
        self.performSegue(withIdentifier: "AboutVC", sender: navigationController)
    }
    
    
    //SHARE BUTTON
    
    @IBAction func shareButton(_ sender: Any) {
        
        let mainVC = UIActivityViewController(activityItems: ["Take a look at this amazing app. which can convert different currencies, it's called 'Smart Currency'"], applicationActivities: nil)
        mainVC.popoverPresentationController?.sourceView = self.view
        self.present(mainVC, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectVC = segue.destination as? SelectCurrencyPop, segue.identifier == "SelectCurrencyPop" {
            selectVC.selectionDelegate = self

        }
        if let rateVC = segue.destination as? RatesVC, segue.identifier == "RatesVC" {
            rateVC.currencySelected = self.selectedRateforInfo
        }
    }
    
   
    
    
    //MARK: HIDE KEYBORD IF TOUCHES BEGAN ON THE SCREEN
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

}

    //MARK:TABLE VIEW CONFIGURATIONS

    extension MainScreenVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = receivedTitle[indexPath.row]
        let rates = currentAmount[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AmountCell
        cell.newLabel.text = (title)
        formatter.numberStyle = .decimal
        cell.rateLabel.text = (formatter.string(from:rates as NSNumber))
        cell.flagOfCurrency(image: title)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentCell = tableView.cellForRow(at: indexPath) as! AmountCell
        tableView.deselectRow(at: indexPath, animated: true)
         self.selectedRateforInfo = currentCell.newLabel.text!
        self.performSegue(withIdentifier: "RatesVC", sender: currentCell)

        }

}
    //MARK RECEIVED INFO FROM POP UP
    extension MainScreenVC: transferSelectedRateDelegate{
    func rateReceived(selectedCurrency: String) {
        selectedCurrencyLabel.text = selectedCurrency
        getData(nameOfCurrency: selectedCurrencyLabel.text)
        tableView.reloadData()
    }
    
}


extension MainScreenVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        //Prevent "0" characters as the first characters. (i.e.: There should not be values like "003" "01" "000012" etc.)
        if inputTextField.text?.count == 0 && string == "0" {
            Alert.showBasic(title: "Incorrect input", msg: "First number can't be 0", vc: self)
            return false
        }
        
        //Limit the character count to 10.
        if ((inputTextField.text!) + string).count > 10 {
            Alert.showBasic(title: "Max Length", msg: "Maximum amount of numbers in the field is 10", vc: self)
            return false
        }
        
        //Have a decimal keypad. Which means user will be able to enter Double values. (Needless to say "." will be limited one)
        if (inputTextField.text?.contains("."))! && string == "." {
            Alert.showBasic(title: "Incorrect input", msg: "Please check the field", vc: self)
            return false
        }
        
        //Only allow numbers. No Copy-Paste text values.
        let allowedCharacterSet = CharacterSet.init(charactersIn: "0123456789.")
        let textCharacterSet = CharacterSet.init(charactersIn: inputTextField.text! + string)
        if !allowedCharacterSet.isSuperset(of: textCharacterSet) {
            return false
        }
        return true
    }
}



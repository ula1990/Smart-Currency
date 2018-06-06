//
//  CurrenciesTableExtension.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 05/06/2018.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension MainVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let amount = currentAmount[indexPath.row]
        let currency = receivedCurrencies[indexPath.row]
        let cell = currenciesTable.dequeueReusableCell(withIdentifier: resultCellId) as! CurrencyCell
        cell.updateCellData(rate: currency.rate!, currencyTitle: currency.name!, amount: String(amount))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currenciesTable.deselectRow(at: indexPath, animated: true)
        
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let closeAction = UIContextualAction(style: .normal, title:  "Close", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            let cell = self.currenciesTable.cellForRow(at: indexPath) as! CurrencyCell
            UIPasteboard.general.string = cell.amountLabel.text
            
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}


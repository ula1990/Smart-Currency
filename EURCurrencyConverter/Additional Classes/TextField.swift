//
//  TextField.swift
//  EURCurrencyConverter
//
//  Created by Ulad Daratsiuk-Demchuk on 2018-01-22.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

class textField: UITextField {
    
    var maxLength: Int = 10
    
    override func willMove(toSuperview newSuperview: UIView?) {
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        editingChanged(self)
    }
    @objc func editingChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        textField.text = String(text.prefix(maxLength))
    }
    
    //BLOCK PASTE FUNCTION
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    
}

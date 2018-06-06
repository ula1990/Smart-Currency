//
//  SelectCurrencyPop.swift
//  EURCurrencyConverter
//
//  Created by Ulad Daratsiuk-Demchuk on 2018-01-19.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class SelectCurrencyPop: UIViewController {
    
    var currencyNames = ["EUR", "USD", "CAD", "GBP", "RUB","CNY", "PLN", "THB", "BGN", "AUD", "SEK", "ILS", "BRL", "DKK", "CHF", "MXN", "HRK", "RON", "TRY", "SGD", "NOK", "HUF", "NZD", "MYR", "IDR", "KRW", "JPY", "INR", "PHP", "CZK", "HKD", "ZAR"]
    var selectedCurrency: String?
    
    lazy var selectView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 5
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.2
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.textAlignment = .center
        label.text = "Select currency"
        return label
    }()
    
    lazy var selectPicker: UIPickerView = {
        let view = UIPickerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var dismissViewButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.textColor = UIColor.red
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.purple.withAlphaComponent(0.5)
        return button
    }()
    fileprivate func setupView(){
        selectView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        selectView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        selectView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: selectView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: selectView.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: selectView.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: selectView.rightAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        selectPicker.centerXAnchor.constraint(equalTo: selectView.centerXAnchor).isActive = true
        selectPicker.centerYAnchor.constraint(equalTo: selectView.centerYAnchor).isActive = true
        selectPicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        selectPicker.leftAnchor.constraint(equalTo: selectView.leftAnchor).isActive = true
        selectPicker.rightAnchor.constraint(equalTo: selectView.rightAnchor).isActive = true
        selectPicker.bottomAnchor.constraint(equalTo: dismissViewButton.topAnchor).isActive = true
        
        dismissViewButton.centerXAnchor.constraint(equalTo: selectView.centerXAnchor).isActive = true
        dismissViewButton.bottomAnchor.constraint(equalTo: selectView.bottomAnchor,constant: -5).isActive = true
        dismissViewButton.leftAnchor.constraint(equalTo: selectView.leftAnchor,constant: 5).isActive = true
        dismissViewButton.rightAnchor.constraint(equalTo: selectView.rightAnchor,constant: -5).isActive = true
        dismissViewButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    fileprivate func addElements() {
        view.addSubview(selectView)
        selectView.addSubview(titleLabel)
        selectView.addSubview(selectPicker)
        selectView.addSubview(dismissViewButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        addElements()
        setupView()
        selectPicker.delegate = self
        selectPicker.dataSource = self

    }
}






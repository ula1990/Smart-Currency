//
//  MainScreenVC.swift
//  EURCurrencyConverter
//
//  Created by Ulad Daratsiuk-Demchuk on 2018-01-19.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    var currentAmount: [Double] = []
    var receivedCurrencies: [Currency] = []
    var oldCurrencies: [Currency] = []
    var selectedCurrencyActual: String = "EUR"
    var selectedRateforInfo: String?
    let formatter = NumberFormatter()
    let resultCellId = "resultCellId"
    let rateCellId = "rateCellId"
    let menuCellId = "menuCellId"
    var currencyObserver: NSObjectProtocol?
    var justOnce: Bool = true
    var differenceInRates: [Double] = []
    var menuShowing = false
    var menuHeightAnchor: NSLayoutConstraint?
    var menuList: [MenuModel] = []
    
    lazy var menuView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 5
        return view
    }()

    lazy var menuTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = UITableViewCellSeparatorStyle.none
        table.layer.cornerRadius = 5
        table.backgroundColor = UIColor.white.withAlphaComponent(0)
        table.isScrollEnabled = false
        table.register(MenuCell.self, forCellReuseIdentifier: menuCellId)
        return table
    }()
    
    lazy var lastUpdateDateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.textAlignment = .left
        label.text = "Last update: Unknown"
        return label
    }()
    
    lazy var updateRatesButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "update"), for: .normal)
        button.addTarget(self, action: #selector(handleUpdateCurrencies), for: .touchUpInside)
        return button
    }()
    
    lazy var inputTextView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
        return view
    }()
    
    lazy var inputTextField: UITextField = {
       let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter Amount"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.layer.cornerRadius = 5
        tf.layer.borderColor = UIColor.gray.cgColor.copy(alpha: 0.2)
        tf.layer.borderWidth = 1
        tf.textAlignment = .center
        tf.addTarget(self, action: #selector(handleInput), for: .allEditingEvents)
        return tf
    }()
    
    lazy var selectedCurrencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.textAlignment = .right
        label.text = "Current: EUR"
        return label
    }()
    
    lazy var selectCurrencyButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select currency", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.textColor = UIColor.white.withAlphaComponent(0.8)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 5
        button.layer.cornerRadius = 5
        button.backgroundColor = UIColor.purple.withAlphaComponent(0.5)
        button.addTarget(self, action: #selector(handleSelectCurrency), for: .touchUpInside)
        return button
    }()
    
    lazy var currenciesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 5
        view.backgroundColor = .white
        view.clipsToBounds = false
        return view
    }()
    
    lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.textAlignment = .left
        label.text = "Results:"
        return label
    }()
    
    lazy var currenciesTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 5
        table.register(CurrencyCell.self, forCellReuseIdentifier: resultCellId)
        table.clipsToBounds = false
        return table
    }()
    
    lazy var rateInfoCollection : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 1, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(RateCell.self, forCellWithReuseIdentifier: rateCellId)
        view.backgroundColor = UIColor.white
        view.isScrollEnabled = true
        return view
    }()


    @objc fileprivate func setupView(){
    
        
        menuView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        menuView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        menuHeightAnchor = menuView.heightAnchor.constraint(equalToConstant: 0)
        menuHeightAnchor?.isActive = true
        
        
        menuTable.centerXAnchor.constraint(equalTo: menuView.centerXAnchor).isActive = true
        menuTable.topAnchor.constraint(equalTo: menuView.topAnchor).isActive = true
        menuTable.bottomAnchor.constraint(equalTo: menuView.bottomAnchor).isActive = true
        menuTable.leftAnchor.constraint(equalTo: menuView.leftAnchor).isActive = true
        menuTable.rightAnchor.constraint(equalTo: menuView.rightAnchor).isActive = true
        
        lastUpdateDateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        lastUpdateDateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lastUpdateDateLabel.widthAnchor.constraint(equalToConstant: 150).isActive = true
        lastUpdateDateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        updateRatesButton.centerYAnchor.constraint(equalTo: lastUpdateDateLabel.centerYAnchor).isActive = true
        updateRatesButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        updateRatesButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        updateRatesButton.leftAnchor.constraint(equalTo: lastUpdateDateLabel.rightAnchor, constant: 2).isActive = true
  
        inputTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputTextView.topAnchor.constraint(equalTo: lastUpdateDateLabel.bottomAnchor, constant: 10).isActive = true
        inputTextView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        inputTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        inputTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        inputTextField.centerXAnchor.constraint(equalTo: inputTextView.centerXAnchor, constant: 0).isActive = true
        inputTextField.topAnchor.constraint(equalTo: inputTextView.topAnchor, constant: 10).isActive = true
        inputTextField.bottomAnchor.constraint(equalTo: inputTextView.bottomAnchor, constant: -10).isActive = true
        inputTextField.leftAnchor.constraint(equalTo: inputTextView.leftAnchor, constant: 10).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: inputTextView.rightAnchor, constant: -10).isActive = true
        
        selectedCurrencyLabel.centerYAnchor.constraint(equalTo: lastUpdateDateLabel.centerYAnchor).isActive = true
        selectedCurrencyLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        selectedCurrencyLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        selectedCurrencyLabel.widthAnchor.constraint(equalToConstant: 110).isActive = true
        
        selectCurrencyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        selectCurrencyButton.topAnchor.constraint(equalTo: inputTextView.bottomAnchor, constant: 20).isActive = true
        selectCurrencyButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        selectCurrencyButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        selectCurrencyButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true

        
        rateInfoCollection.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rateInfoCollection.topAnchor.constraint(equalTo: selectCurrencyButton.bottomAnchor, constant: 20).isActive = true
        rateInfoCollection.heightAnchor.constraint(equalToConstant: 80).isActive = true
        rateInfoCollection.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        rateInfoCollection.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        currenciesView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        currenciesView.topAnchor.constraint(equalTo: rateInfoCollection.bottomAnchor, constant: 20).isActive = true
        currenciesView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        currenciesView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        currenciesView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
      
        resultLabel.topAnchor.constraint(equalTo: currenciesView.topAnchor, constant: 10).isActive = true
        resultLabel.leftAnchor.constraint(equalTo: currenciesView.leftAnchor, constant: 10).isActive = true
        resultLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        resultLabel.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        currenciesTable.centerXAnchor.constraint(equalTo: currenciesView.centerXAnchor).isActive = true
        currenciesTable.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 10).isActive = true
        currenciesTable.bottomAnchor.constraint(equalTo: currenciesView.bottomAnchor, constant: -10).isActive = true
        currenciesTable.leftAnchor.constraint(equalTo: currenciesView.leftAnchor, constant: 10).isActive = true
        currenciesTable.rightAnchor.constraint(equalTo: currenciesView.rightAnchor, constant: -10).isActive = true
    }
    
    fileprivate func setupNavBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named:"menu"), style: .plain, target: self, action: #selector(handleMenu))
//        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named:"share"), style: .plain, target: self, action: #selector(handleShare))
//        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(menuView)
        view.addSubview(lastUpdateDateLabel)
        view.addSubview(inputTextView)
        view.addSubview(updateRatesButton)
        view.addSubview(selectedCurrencyLabel)
        view.addSubview(selectCurrencyButton)
        view.addSubview(currenciesView)
        view.addSubview(rateInfoCollection)
        currenciesView.addSubview(resultLabel)
        currenciesView.addSubview(currenciesTable)
        inputTextView.addSubview(inputTextField)
        view.addSubview(menuView)
        menuView.addSubview(menuTable)
        view.backgroundColor = .white
        setupNavBar()
        setupView()
        currenciesTable.delegate = self
        currenciesTable.dataSource = self
        inputTextField.delegate = self
        rateInfoCollection.delegate = self
        rateInfoCollection.dataSource = self
        menuTable.delegate = self
        menuTable.dataSource = self
        menuList = creatMenuArray()
        getData(nameOfCurrency: selectedCurrencyActual)
        
        currencyObserver = NotificationCenter.default.addObserver(forName: .selectCurrency, object: nil, queue: OperationQueue.main, using: { (notification) in
            let selectCurVC = notification.object as! SelectCurrencyPop
            self.selectedCurrencyLabel.text = "Current: " + selectCurVC.selectedCurrency!
            self.selectedCurrencyActual = selectCurVC.selectedCurrency!
            self.getData(nameOfCurrency: self.selectedCurrencyActual)
            
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let currencyObserver = currencyObserver{
            NotificationCenter.default.removeObserver(currencyObserver)
        }
    }

}

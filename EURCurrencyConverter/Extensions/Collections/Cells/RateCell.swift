//
//  RateCell.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 6/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class RateCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    let mainCurrencyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.black.withAlphaComponent(0.4)
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    let loadedCurrencyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.black.withAlphaComponent(0.4)
        label.font = UIFont.systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        return label
    }()
    
    let currentRateInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.font = UIFont.systemFont(ofSize: 12)
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4
        return label
    }()
    
    let rateDifferenceInfo: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = UIColor.white.withAlphaComponent(1)
        label.font = UIFont.systemFont(ofSize: 12)
        label.layer.cornerRadius = 2
        label.clipsToBounds = true
        label.backgroundColor = UIColor.red.withAlphaComponent(0.65)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4
        return label
    }()
    
    func  setupView(){

        addSubview(mainCurrencyName)
        addSubview(currentRateInfo)
        addSubview(loadedCurrencyName)
        addSubview(rateDifferenceInfo)
        
        mainCurrencyName.topAnchor.constraint(equalTo: self.topAnchor,constant: 5).isActive = true
        mainCurrencyName.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 20).isActive = true
        mainCurrencyName.widthAnchor.constraint(equalToConstant: 30).isActive = true
        mainCurrencyName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        loadedCurrencyName.topAnchor.constraint(equalTo: self.topAnchor,constant: 5).isActive = true
        loadedCurrencyName.leftAnchor.constraint(equalTo: mainCurrencyName.rightAnchor,constant: 1).isActive = true
        loadedCurrencyName.widthAnchor.constraint(equalToConstant: 25).isActive = true
        loadedCurrencyName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        currentRateInfo.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10).isActive = true
        currentRateInfo.leftAnchor.constraint(equalTo: self.leftAnchor,constant: 5).isActive = true
        currentRateInfo.heightAnchor.constraint(equalToConstant: 20).isActive = true
        currentRateInfo.widthAnchor.constraint(equalToConstant: 35).isActive = true
        
        rateDifferenceInfo.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10).isActive = true
        rateDifferenceInfo.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -5).isActive = true
        rateDifferenceInfo.heightAnchor.constraint(equalToConstant: 20).isActive = true
        rateDifferenceInfo.widthAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    func updateCellData(currency: Currency, selectedCurrency: String?, differenceInRate: Double){
        mainCurrencyName.text = selectedCurrency! + "/"
        loadedCurrencyName.text = currency.name
        currentRateInfo.text = String(currency.rate!)
        rateDifferenceInfo.text = String(differenceInRate)
        changeColorForLabel()
    }
    
    func changeColorForLabel(){
        if rateDifferenceInfo.text!.range(of:"-") != nil {
            rateDifferenceInfo.backgroundColor = UIColor.red.withAlphaComponent(0.65)
        }else{
            rateDifferenceInfo.backgroundColor = UIColor.init(red: 0.1, green: 0.7, blue: 0.1, alpha: 0.8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

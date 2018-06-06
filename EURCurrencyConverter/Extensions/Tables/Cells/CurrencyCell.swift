//
//  RatesCell.swift
//  EURCurrencyConverter
//
//  Created by Ulad Daratsiuk-Demchuk on 2018-01-19.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {

    lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.4
        return label
    }()
    
    lazy var nameOfCurrency: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        return label
    }()
    
    lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        return label
    }()
    
    lazy var flagImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        image.layer.cornerRadius = 5
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        return image
    }()
    
    lazy var menuImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        image.layer.cornerRadius = 5
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = false
        image.clipsToBounds = true
        image.image = UIImage(named: "stocks")
        return image
    }()
    
    fileprivate func setupViews(){
        
        flagImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        flagImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 1).isActive = true
        flagImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        flagImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        nameOfCurrency.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nameOfCurrency.leftAnchor.constraint(equalTo: flagImage.rightAnchor, constant: 20).isActive = true
        nameOfCurrency.heightAnchor.constraint(equalToConstant: 40).isActive = true
        nameOfCurrency.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        rateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        rateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        rateLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        rateLabel.leftAnchor.constraint(equalTo: nameOfCurrency.rightAnchor, constant: 10).isActive = true
        rateLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        amountLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        amountLabel.rightAnchor.constraint(equalTo: menuImage.leftAnchor, constant: -10).isActive = true
        amountLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        amountLabel.leftAnchor.constraint(equalTo: rateLabel.rightAnchor, constant: 2).isActive = true
        amountLabel.rightAnchor.constraint(equalTo: menuImage.leftAnchor, constant: 2).isActive = true
        
        menuImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        menuImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        menuImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        menuImage.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(amountLabel)
        addSubview(nameOfCurrency)
        addSubview(rateLabel)
        addSubview(flagImage)
        addSubview(menuImage)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateCellData(rate: Double, currencyTitle: String, amount: String){
        self.flagImage.image = UIImage(named: currencyTitle)
        nameOfCurrency.text = currencyTitle
        rateLabel.text = String(rate)
        amountLabel.text = amount + "-"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

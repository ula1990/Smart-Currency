//
//  MenuCell.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 6/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    lazy var menuIcon: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.cornerRadius = 2
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor.darkGray
        return image
    }()
    
    lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.darkText
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        return label
    }()
    
    
    fileprivate func setupViews(){
        menuIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        menuIcon.rightAnchor.constraint(equalTo: menuLabel.leftAnchor, constant: -10).isActive = true
        menuIcon.heightAnchor.constraint(equalToConstant: 30).isActive = true
        menuIcon.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        menuLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        menuLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 15).isActive = true
        menuLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        menuLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    public func updateMenu(menuModel: MenuModel){
        menuIcon.image = menuModel.icon
        menuLabel.text = menuModel.title
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(menuIcon)
        addSubview(menuLabel)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }


}

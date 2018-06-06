//
//  NewsVC.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 6/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import UIKit

class NewsVC: UIViewController {
    
    let newsCellId = "newsCellId"
    let newsUrl = "https://newsapi.org/v2/top-headlines?sources=bloomberg&apiKey="
    let token = "54fde7b8bbba4883abdf30f18bcea926"
    var news: [Article] = []
    
    lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 5
        view.layer.cornerRadius = 5
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.black.withAlphaComponent(0.5)
        label.textAlignment = .center
        label.text = "Last News:"
        return label
    }()
    
    lazy var updateNewsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "update"), for: .normal)
        button.addTarget(self, action: #selector(handleUpdate), for: .touchUpInside)
        return button
    }()
    
    lazy var newsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 5
        table.backgroundColor = UIColor.white.withAlphaComponent(0)
        table.register(NewsCell.self, forCellReuseIdentifier: newsCellId)
        return table
    }()
    
    @objc fileprivate func setupView(){
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainView.topAnchor.constraint(equalTo: view.topAnchor,constant: 70).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -10).isActive = true
        mainView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10).isActive = true
        mainView.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -10).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: mainView.topAnchor,constant: 10).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        updateNewsButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        updateNewsButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        updateNewsButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        updateNewsButton.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 2).isActive = true

        newsTable.centerXAnchor.constraint(equalTo: mainView.centerXAnchor).isActive = true
        newsTable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 10).isActive = true
        newsTable.bottomAnchor.constraint(equalTo: mainView.bottomAnchor,constant: -10).isActive = true
        newsTable.leftAnchor.constraint(equalTo: mainView.leftAnchor,constant: 10).isActive = true
        newsTable.rightAnchor.constraint(equalTo: mainView.rightAnchor,constant: -10).isActive = true
        
    }
    
    fileprivate func setupNavBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(mainView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(newsTable)
        mainView.addSubview(updateNewsButton)
        newsTable.delegate = self
        newsTable.dataSource = self
        setupView()
        setupNavBar()
        getDataNews(token: token)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
 
}

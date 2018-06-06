//
//  NewsVCHandler.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 6/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension NewsVC {
    @objc public func getDataNews(token: String?){
        self.news.removeAll()
        let url = URL(string: newsUrl + token!)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            //FOR FASTER WORK OF PICKERVIEW
            DispatchQueue.main.async {
                if error != nil{
                    Alert.showBasic(title: "Offline Mode", msg: "Please check connection and update the rates,in offline mode available only EUR", vc: self)
                }
                else{
                    if data != nil{
                        do {
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                            
                            if let articlesFromJson = json["articles"] as? [[String : AnyObject]] {
                                for articleFromJson in articlesFromJson {
                                    let article = Article()
                                    if let title = articleFromJson["title"] as? String, let author = articleFromJson["author"] as? String, let desc = articleFromJson["description"] as? String, let url = articleFromJson["url"] as? String, let urlToImage = articleFromJson["urlToImage"] as? String,let publishedAt = articleFromJson["publishedAt"] as? String {
                                        
                                        article.author = author
                                        article.desc = desc
                                        article.headline = title
                                        article.url = url
                                        article.imageUrl = urlToImage
                                        article.publishedAt = publishedAt
                                    }
                                    self.news.append(article)
                                }
                            }
                            
                        }
                        catch{
                            print(Error.self)
                        }
                    }
                }
                self.newsTable.reloadData()
            }
        }
        task.resume()
    }

}

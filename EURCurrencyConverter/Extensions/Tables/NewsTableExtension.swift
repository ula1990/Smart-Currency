//
//  File.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 6/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsOffline.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = newsOffline[indexPath.row]
        let cell = newsTable.dequeueReusableCell(withIdentifier: newsCellId, for: indexPath) as! NewsCell
        cell.updateData(title: article.headline, description: article.desc, imageUrl: article.imageUrl!, pubDate: article.publishedAt)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = newsOffline[indexPath.row]
        let articleUrl = URL(string: article.url!)
        let safariVC = SFSafariViewController(url: articleUrl!)
        present(safariVC, animated: true, completion: nil)
        newsTable.deselectRow(at: indexPath, animated: true)
    }
    
    
}

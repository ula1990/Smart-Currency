//
//  RateCollectionViewExtension.swift
//  EURCurrencyConverter
//
//  Created by Uladzislau Daratsiuk on 6/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import Foundation
import UIKit

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return receivedCurrencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currency = receivedCurrencies[indexPath.row]
        let currencyDifference = differenceInRates[indexPath.row]
        let cell  = rateInfoCollection.dequeueReusableCell(withReuseIdentifier: rateCellId, for: indexPath) as! RateCell
        cell.backgroundColor = .white
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowRadius = 3
        cell.layer.cornerRadius = 5
        cell.updateCellData(currency: currency, selectedCurrency: selectedCurrencyActual, differenceInRate: currencyDifference )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 60)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 10)
    }
    
    
}

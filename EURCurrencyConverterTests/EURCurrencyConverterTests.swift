//
//  EURCurrencyConverterTests.swift
//  EURCurrencyConverterTests
//
//  Created by Uladzislau Daratsiuk on 6/6/18.
//  Copyright © 2018 Uladzislau Daratsiuk. All rights reserved.
//

import XCTest
@testable import EURCurrencyConverter

class EURCurrencyConverterTests: XCTestCase {
    
    func testCurrentCurrency(){
        let currencyName: String?
        currencyName = MainVC().selectedCurrencyActual
        XCTAssertEqual(currencyName, "EUR")
    }
    
 
}

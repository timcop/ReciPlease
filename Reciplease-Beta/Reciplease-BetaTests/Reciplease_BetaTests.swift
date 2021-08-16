//
//  Reciplease_BetaTests.swift
//  Reciplease-BetaTests
//
//  Created by Samuel Royal on 16/08/21.
//  Copyright © 2021 Samuel Royal. All rights reserved.
//

import XCTest
@testable import Reciplease_Beta

class Reciplease_BetaTests: XCTestCase {
    
    func testIngredientsFilled() {
        let miss = Data.fillProds()
        sleep(3)
        print(Data.Ingredients)
        print(Data.Ingredients.count)
        XCTAssert(Data.Ingredients.count > 0, "No ingredients have been put into array")
    }
    
    func testMissingReci() {
        let miss = Data.fillProds()
        sleep(3)
        XCTAssert(miss.count == 1, "Missing relation?")
    }
    
    func testDataFuncs() {
        Data.fillProds()
        sleep(3)
        var ingreds = print(Data.Ingredients)
        var searched = Data.searchItem("")
        print(searched)
        
    }
}


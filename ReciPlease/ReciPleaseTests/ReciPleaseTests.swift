//
//  ReciPleaseTests.swift
//  ReciPleaseTests
//
//  Created by Tim Copland on 28/09/21.
//

import XCTest
import SwiftUI
@testable import ReciPlease
//@testable import RecipeModel

class ReciPleaseTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSavingLoading() throws {
        let recipeModel = RecipeModel()
        recipeModel.recipes.append(Recipe())
        
        var ing = Ingredient()
        ing.name = "Name"
        ing.quantity = 2
        recipeModel.recipes[0].ingredients.append(ing)
        ing.quantity = 2.12
        recipeModel.recipes[0].ingredients.append(ing)
        var step = Step()
        step.string = "Step 1"
        recipeModel.recipes[0].method.append(step)
        step.string = "Step 2"
        recipeModel.recipes[0].method.append(step)

        
        
        recipeModel.storeRecList(recs: recipeModel.recipes)
        let recipeModel2 = RecipeModel()
        recipeModel2.recipes = recipeModel2.getRecList()
        XCTAssert(recipeModel.recipes.count == recipeModel2.recipes.count)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testApiCall() async throws {
        let productsModel = ProductsModel()
        
        // Should show results
        var products = try! await productsModel.getProducts(searchTerm: "banana")
        XCTAssert(products.count != 0)
        
        //Should have no results
        products = try! await productsModel.getProducts(searchTerm: "abcaouhdsa81313")
        XCTAssert(products.count == 0)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

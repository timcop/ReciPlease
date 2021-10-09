//
//  ReciPleaseUITests.swift
//  ReciPleaseUITests
//
//  Created by Tim Copland on 28/09/21.
//

import XCTest
@testable import ReciPlease
class ReciPleaseUITests: XCTestCase {

    override func setUpWithError() throws {
//        let recipeModel = RecipeModel()
//        recipeModel.storeRecList(recs: recipeModel.recipes)
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        let recipeModel = RecipeModel()
//        recipeModel.storeRecList(recs: recipeModel.recipes)
    }


    
    func testNameIngredientRecipe() throws {
//        let recipeModel = RecipeModel()
        let app = XCUIApplication()
        app.launch()
        
        let nKey = app/*@START_MENU_TOKEN@*/.keys["N"]/*[[".keyboards.keys[\"N\"]",".keys[\"N\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let moreKey = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"numbers\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        let oneKey = app.keys["1"]
        
        app.buttons["Add a recipe"].tap()
        app.scrollViews.otherElements.textFields["Recipe Name"].tap()
        nKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let elementsQuery = app.scrollViews.otherElements

        elementsQuery.buttons["Add ingredient"].tap()
        app.tables.textFields["Name"].tap()
        nKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()

        app.tables.textFields["Quantity"].tap()
        moreKey.tap()
        oneKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"return\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
        app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).matching(identifier: "Submit").element(boundBy: 1).tap()
        
        
        app.buttons["Submit"].tap()
        
       
    }
    
    func testRandomButton() throws {
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["Random recipe"].tap()
        app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["ReciPlease"].tap()
        
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}

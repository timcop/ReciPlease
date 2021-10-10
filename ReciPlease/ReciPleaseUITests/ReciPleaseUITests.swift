//
//  ReciPleaseUITests.swift
//  ReciPleaseUITests
//
//  Created by Tim Copland on 28/09/21.
//

import XCTest
//@testable import ReciPlease
class ReciPleaseUITests: XCTestCase {

    override func setUpWithError() throws {
//        let recipeModel = RecipeModel() as RecipeModel
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


    
    func testAddRecipe() throws {

        
        let app = XCUIApplication()
        app.launch()
        app.buttons["AddRecipe"].tap()
        
        let keys = app.keys
        let recipeName = app.textFields["RecipeNameField"]
        recipeName.waitForExistence(timeout: 5)
        recipeName.tap()
        recipeName.typeText("Name")
        
        
        let recipeTime = app.textFields["RecipeTimeField"]
        recipeTime.waitForExistence(timeout: 5)
        recipeTime.tap()
        recipeTime.typeText("Name")
        
        let recipeServings = app.textFields["RecipeServingsField"]
        recipeServings.waitForExistence(timeout: 5)
        recipeServings.tap()
        recipeServings.typeText("Name")
        app.keyboards.buttons["return"].tap()
        
        app.buttons["AddIngredient"].tap()

        
        app.buttons["IngredientCancel"].tap()


        app.buttons["CancelRecipe"].tap()

    }
    
    func testRandomButton() throws {
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["Random recipe"].tap()
        app.buttons["MethodToggle"].firstMatch.tap()
        app.buttons["IngredientToggle"].firstMatch.tap()
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

extension XCUIElement {
    func typeTextAlt(_ text: String) {
        // Solution for `Neither element nor any descendant has keyboard focus.`
        if !(self.value(forKey: "hasKeyboardFocus") as? Bool ?? false) {
            XCUIDevice.shared.press(XCUIDevice.Button.home)
            XCUIApplication().activate()
        }
        self.typeText(text)
    }
}

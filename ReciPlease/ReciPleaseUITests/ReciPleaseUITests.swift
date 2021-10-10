//
//  ReciPleaseUITests.swift
//  ReciPleaseUITests
//
//  Created by Tim Copland on 28/09/21.
//

import XCTest
//@testable import ReciPlease
class ReciPleaseUITests: XCTestCase {


    func testAddRecipe() throws {

        
        let app = XCUIApplication()
        app.launch()
        app.buttons["AddRecipe"].tap()
        
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
        app.buttons["SearchProduct"].tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()

        
        app.buttons["IngredientCancel"].tap()
        
        app.buttons["MethodToggle"].firstMatch.tap()
        sleep(2)
        app.buttons["AddStep"].tap()
        app.buttons["CancelStep"].tap()
        
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

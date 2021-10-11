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
        XCTAssertTrue(recipeName.waitForExistence(timeout: 5))
        recipeName.tap()
        recipeName.typeText("Test")
        
        
        let recipeTime = app.textFields["RecipeTimeField"]
        XCTAssertTrue(recipeTime.waitForExistence(timeout: 5))
        recipeTime.tap()
        recipeTime.typeText("Test")
        
        let recipeServings = app.textFields["RecipeServingsField"]
        XCTAssertTrue(recipeServings.waitForExistence(timeout: 5))
        recipeServings.tap()
        recipeServings.typeText("Test")
        app.keyboards.buttons["return"].tap()
        
        app.buttons["AddIngredient"].tap()
//        app.buttons["OutsideEditIngredient"].tap()
//        app.buttons["AddIngredient"].tap()
        
        let ingredientName = app.textFields["IngredientNameField"]
        XCTAssertTrue(ingredientName.waitForExistence(timeout: 5))
        ingredientName.tap()
        ingredientName.typeText("Test")
        
        let ingredientUnit = app.textFields["IngredientUnitField"]
        XCTAssertTrue(ingredientUnit.waitForExistence(timeout: 5))
        ingredientUnit.tap()
        ingredientUnit.typeText("Test")
        
        let ingredientQuantity = app.textFields["IngredientQuantityField"]
        XCTAssertTrue(ingredientQuantity.waitForExistence(timeout: 5))
        ingredientQuantity.tap()
        ingredientQuantity.typeText("Test")
        app.keyboards.buttons["return"].tap()
        ingredientQuantity.tap()
        ingredientQuantity.typeText("1")
        app.keyboards.buttons["return"].tap()
        
        app.buttons["SearchProduct"].tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        app.buttons["IngredientSubmitButton"].tap()
        
        app.buttons["MethodToggle"].firstMatch.tap()
        
        app.scrollViews.otherElements.buttons["AddStep"].tap()
        app.textViews["StepTextPlaceholder"].tap()
        app.textViews["StepText"].typeText("Test")
        app.buttons["SubmitStep"].tap()
        
        app.buttons["SubmitRecipe"].tap()
        
        
    }
    
    func testEditRecipe() throws {
        
        let app = XCUIApplication()
        app.launch()
        let scrollViewsQuery = app.scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.buttons["Recipe"].firstMatch.tap()
        
        app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Edit"].tap()
        
        let recipeNameTextField = elementsQuery.textFields["Recipe Name"]
        recipeNameTextField.tap()
        recipeNameTextField.typeText("Test")
        
        let cookTimeField = elementsQuery.textFields["30 Mins"]
        cookTimeField.tap()
        cookTimeField.typeText("Test")
        
        let servingsField = elementsQuery.textFields["4 Servings"]
        servingsField.tap()
        servingsField.typeText("Test")
        
        let editElementsQuery = scrollViewsQuery.otherElements.containing(.image, identifier:"Edit")
        editElementsQuery.children(matching: .image).matching(identifier: "Edit").element(boundBy: 1).tap()
        let ingredientName = app.textFields["IngredientNameField"]
        XCTAssertTrue(ingredientName.waitForExistence(timeout: 5))
        ingredientName.tap()
        ingredientName.typeText("Test")
        let ingredientUnit = app.textFields["IngredientUnitField"]
        XCTAssertTrue(ingredientUnit.waitForExistence(timeout: 5))
        ingredientUnit.tap()
        ingredientUnit.typeText("Test")
        let ingredientQuantity = app.textFields["IngredientQuantityField"]
        XCTAssertTrue(ingredientQuantity.waitForExistence(timeout: 5))
        ingredientQuantity.tap()
        ingredientQuantity.typeText("Test")
        app.keyboards.buttons["return"].tap()
        ingredientQuantity.tap()
        ingredientQuantity.typeText("1")
        app.keyboards.buttons["return"].tap()
        app.buttons["SearchProduct"].tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.buttons["IngredientSubmitButton"].tap()
        
        editElementsQuery.children(matching: .image).matching(identifier: "Trash").element(boundBy: 1).tap()
        
        app.buttons["Add Ingredient"].tap()
        
        XCTAssertTrue(ingredientName.waitForExistence(timeout: 5))
        ingredientName.tap()
        ingredientName.typeText("Test")
        XCTAssertTrue(ingredientUnit.waitForExistence(timeout: 5))
        ingredientUnit.tap()
        ingredientUnit.typeText("Test")
        XCTAssertTrue(ingredientQuantity.waitForExistence(timeout: 5))
        ingredientQuantity.tap()
        ingredientQuantity.typeText("Test")
        app.keyboards.buttons["return"].tap()
        ingredientQuantity.tap()
        ingredientQuantity.typeText("1")
        app.keyboards.buttons["return"].tap()
        app.buttons["SearchProduct"].tap()
        app.navigationBars.buttons.element(boundBy: 0).tap()
        app.buttons["IngredientSubmitButton"].tap()
        
        app.buttons["MethodToggle"].firstMatch.tap()
        
        editElementsQuery.children(matching: .image).matching(identifier: "Edit").element(boundBy: 1).tap()
        app.textViews["StepText"].tap()
        app.textViews["StepText"].typeText("Test")
        app.buttons["SubmitStep"].tap()
        
        app.scrollViews.otherElements.buttons["Add Step"].tap()
        app.textViews["StepTextPlaceholder"].tap()
        app.textViews["StepText"].typeText("Test")
        app.buttons["SubmitStep"].tap()
        
        
        app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Done"].tap()
        
    }
    
    func testRandomButton() throws {
        
        let app = XCUIApplication()
        app.launch()
        app.buttons["Random recipe"].tap()
        app.buttons["MethodToggle"].firstMatch.tap()
        app.buttons["IngredientToggle"].firstMatch.tap()
        app.navigationBars.buttons.element(boundBy: 1).tap()
        sleep(2)

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

//
//  Reciplease_BetaUITests.swift
//  Reciplease-BetaUITests
//
//  Created by Ethan Fraser on 16/08/21.
//  Copyright © 2021 Samuel Royal. All rights reserved.
//

import XCTest
@testable import Reciplease_Beta

class Reciplease_BetaUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    func testUI5() {
        
        let app = XCUIApplication()
        app.buttons["Add Recipe"].tap()
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.textFields["Title"].tap()
//        elementsQuery.buttons["Add Recipe"].tap()
//        app.buttons["Browse your Recipes"].tap()
    }
}

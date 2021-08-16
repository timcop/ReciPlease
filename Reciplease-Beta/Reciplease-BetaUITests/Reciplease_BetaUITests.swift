//
//  Reciplease_BetaUITests.swift
//  Reciplease-BetaUITests
//
//  Created by Ethan Fraser on 16/08/21.
//  Copyright © 2021 Samuel Royal. All rights reserved.
//

import XCTest

class Reciplease_BetaUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
}

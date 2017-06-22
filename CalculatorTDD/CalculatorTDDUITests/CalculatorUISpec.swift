//
//  CalculatorUISpec.swift
//  CalculatorTDD
//
//  Created by Matthew Dabit on 6/15/17.
//  Copyright © 2017 Matthew Dabit. All rights reserved.
//

import XCTest

class CalculatorUISpec: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        // Added snapshot from Fastlane to take screenshots

        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShouldUpdateLabel() {

        let app = XCUIApplication()
        
        app.buttons["1"].tap()
        snapshot("Entered 1")
        XCTAssert(app.staticTexts["1"].exists)
        
        app.buttons["0"].tap()
        snapshot("Entered 10")
        XCTAssert(app.staticTexts["10"].exists)
        
        
        app.buttons["C"].tap()
        app.buttons["."].tap()
        app.buttons["4"].tap()
        
        snapshot("Entered 0.4")
        
        XCTAssert(app.staticTexts["0.4"].exists)
    }
    
    
    func testShouldCalculateUnaryOperations(){
        let app = XCUIApplication()
        
        app.buttons["4"].tap()
        app.buttons["√"].tap()
        snapshot("Sqrt of 4")
        XCTAssert(app.staticTexts["2"].exists)
        
        app.buttons["C"].tap()
        app.buttons["4"].tap()
        app.buttons["x²"].tap()
        snapshot("Square of 4")
        XCTAssert(app.staticTexts["16"].exists)
        
        app.buttons["C"].tap()
        app.buttons["4"].tap()
        app.buttons["±"].tap()
        snapshot("Negative of 4")
        XCTAssert(app.staticTexts["-4"].exists)
        
        app.buttons["C"].tap()
        app.buttons["sin"].tap()
        snapshot("sin(0)")
        XCTAssert(app.staticTexts["0"].exists)
        
        app.buttons["C"].tap()
        app.buttons["cos"].tap()
        snapshot("cos(0)")
        XCTAssert(app.staticTexts["1"].exists)
        
        app.buttons["C"].tap()
        app.buttons["tan"].tap()
        snapshot("tan(0)")
        XCTAssert(app.staticTexts["0"].exists)
    }
    
    func testShouldDisplayConstants() {
        
        let app = XCUIApplication()
        app.buttons["π"].tap()
        
        snapshot("π value")
        
        XCTAssert(app.staticTexts[String(Double.pi)].exists)
        
        app.buttons["C"].tap()
        app.buttons["e"].tap()
        
        snapshot("e value")
        XCTAssert(app.staticTexts[String(M_E)].exists)
    }
 
    func testShouldCalculateBinaryOperations(){
        
        let app = XCUIApplication()
        app.buttons["4"].tap()
        app.buttons["+"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        snapshot("4 + 5")
        XCTAssert(app.staticTexts["9"].exists)
        
        app.buttons["C"].tap()
        app.buttons["4"].tap()
        app.buttons["×"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        snapshot("4 × 5")
        XCTAssert(app.staticTexts["20"].exists)
        
        app.buttons["C"].tap()
        app.buttons["6"].tap()
        app.buttons["-"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        snapshot("6 - 5")
        XCTAssert(app.staticTexts["1"].exists)
        
        app.buttons["C"].tap()
        app.buttons["1"].tap()
        app.buttons["5"].tap()
        app.buttons["÷"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        snapshot("15 ÷ 5")
        XCTAssert(app.staticTexts["3"].exists)
    }
    
    func testShouldClearTheDisplay(){
        
        let app = XCUIApplication()
        app.buttons["1"].tap()
        app.buttons["C"].tap()
        
        snapshot("Clear")
        
        XCTAssert(app.staticTexts["0"].exists)
    }
}

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
    
    func testShouldUpdateLabelTo1() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        
        app.buttons["1"].tap()
        
        snapshot("Entered 1")

        XCTAssert(app.staticTexts["1"].exists)
    }
    
    func testShouldUpdateLabelTo10() {
        let app = XCUIApplication()
        
        app.buttons["1"].tap()
        app.buttons["0"].tap()
        
        snapshot("Entered 10")

        XCTAssert(app.staticTexts["10"].exists)
    }
    
    func testShouldDisplaySqrtOfValue(){
        let app = XCUIApplication()
        
        app.buttons["4"].tap()
        app.buttons["√"].tap()
        
        snapshot("Sqrt of 4")

        XCTAssert(app.staticTexts["2"].exists)
    }
    
    func testShouldDisplaySquareOf4(){
        
        let app = XCUIApplication()
        app.buttons["4"].tap()
        app.buttons["x²"].tap()
        
        snapshot("Square of 4")
        
        XCTAssert(app.staticTexts["16"].exists)
    }
    
    func testShouldDisplayNegativeOfNumber(){
        
        let app = XCUIApplication()
        app.buttons["4"].tap()
        app.buttons["±"].tap()
        
        
        snapshot("Negative of 4")
        XCTAssert(app.staticTexts["-4"].exists)
    }
    
    func testShouldDisplayPi() {
        
        let app = XCUIApplication()
        app.buttons["π"].tap()
        
        XCTAssert(app.staticTexts["3.14159265358979"].exists)

    }
}

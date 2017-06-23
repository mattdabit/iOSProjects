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

    func testShouldShowDescription(){
        let app = XCUIApplication()

        app.buttons["4"].tap()
        app.buttons["+"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        snapshot("4 + 5 description")
        XCTAssert(app.staticTexts["4 + 5 ="].exists)
    }
    
    func testShouldShowDescriptionWhenPending(){
        let app = XCUIApplication()
        
        app.buttons["4"].tap()
        app.buttons["+"].tap()
        app.buttons["5"].tap()
        snapshot("4 + ... description")
        XCTAssert(app.staticTexts["4 + ..."].exists)
        XCTAssert(app.staticTexts["5"].exists)

    }
    
    func testShouldShowDescriptionWhenNotPending(){
        let app = XCUIApplication()
        
        app.buttons["4"].tap()
        app.buttons["+"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        app.buttons["7"].tap()
        app.buttons["3"].tap()

        snapshot("4 + 5 = description edge case")
        XCTAssert(app.staticTexts["4 + 5 ="].exists)
        XCTAssert(app.staticTexts["73"].exists)
    }
    
    func testShouldShowDescriptionAndResultUsingMemory(){
        let app = XCUIApplication()
        
        app.buttons["9"].tap()
        app.buttons["+"].tap()
        app.buttons["M"].tap()
        app.buttons["="].tap()
        app.buttons["√"].tap()
        snapshot("Result: 3 Description: √(9 + M) =")
        XCTAssert(app.staticTexts["√(9 + M) ="].exists)
        XCTAssert(app.staticTexts["3"].exists)

        
        app.buttons["7"].tap()
        app.buttons["→M"].tap()
        snapshot("Result: 4 Description: √(9 + M) =")
        XCTAssert(app.staticTexts["√(9 + M) ="].exists)
        XCTAssert(app.staticTexts["4"].exists)
        XCTAssert(app.staticTexts["M: 7"].exists)

        
        app.buttons["+"].tap()
        app.buttons["1"].tap()
        app.buttons["4"].tap()
        app.buttons["="].tap()

        snapshot("Result: 18 Description: √(9 + M) + 14 =")
        XCTAssert(app.staticTexts["√(9 + M) + 14 ="].exists)
        XCTAssert(app.staticTexts["18"].exists)
    }
    
    func testShouldUndoLastOperation(){
        let app = XCUIApplication()
        
        app.buttons["4"].tap()
        app.buttons["+"].tap()
        app.buttons["5"].tap()
        app.buttons["="].tap()
        app.buttons["undo"].tap()
        
        snapshot("= should be undone")
        XCTAssert(app.staticTexts["4 + 5 ..."].exists)
    }

}

//
//  ToDoUITests.swift
//  ToDoUITests
//
//  Created by B1media on 2016/11/7.
//  Copyright © 2016年 yishainChen. All rights reserved.
//

import XCTest

class ToDoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let app = XCUIApplication()
        app.navigationBars["ToDo.ItemListView"].buttons["Add"].tap()
        let titleTextField = app.textFields["Title"]
        titleTextField.tap()
        titleTextField.typeText("Meeting")
        let dateTextField = app.textFields["Date"]
        dateTextField.tap()
        dateTextField.typeText("02/22/2016")
        let locationNameTextField = app.textFields["Location Name"]
        locationNameTextField.tap()
        locationNameTextField.typeText("Office")
        let addressTextField = app.textFields["Address"]
        addressTextField.tap()
        addressTextField.typeText("Infinite Loop 1, Cupertino")
        let descriptionTextField = app.textFields["Description"]
        descriptionTextField.tap()
        descriptionTextField.typeText("Bring iPad")
        app.buttons["Save"].tap()
        
//        XCTAssertTrue(app.tables.staticTexts["maybe"].exists)
//        XCTAssertTrue(app.tables.staticTexts["02/22/2016"].exists)
//        XCTAssertTrue(app.tables.staticTexts["one"].exists)
    }
    
}

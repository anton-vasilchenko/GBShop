//
//  LoginUITests.swift
//  GBShopUITests
//
//  Created by Антон Васильченко on 25.03.2021.
//

import XCTest

class LoginUITests: XCTestCase {
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLogin() throws {
        let app = XCUIApplication()
        app.launch()
        
        let loginButton = app.buttons["loginButton"].firstMatch
        XCTAssertTrue(loginButton.isHittable)
        
        let loginField = app/*@START_MENU_TOKEN@*/.textFields["loginField"]/*[[".textFields[\"Login\"]",".textFields[\"loginField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.firstMatch
        loginField.tap()
        loginField.typeText("login")
        
        let passwordField = app.textFields["passwordField"].firstMatch
        passwordField.tap()
        passwordField.typeText("password")
        
        loginButton.tap()
        
    }
}

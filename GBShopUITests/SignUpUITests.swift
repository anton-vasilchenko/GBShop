//
//  SignUpUITests.swift
//  GBShopUITests
//
//  Created by Антон Васильченко on 25.03.2021.
//

import XCTest

class SignUpUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        let app = XCUIApplication()
        app.launch()

        app.buttons["signupButton"].firstMatch.tap()
        
        let idField = app.textFields["idField"].firstMatch
        let usernameField = app.textFields["usernameField"].firstMatch
        let passwordField = app.textFields["passwordField"].firstMatch
        let emailField = app.textFields["emailField"].firstMatch
        let genderField = app.textFields["genderField"].firstMatch
        let creditField = app.textFields["creditField"].firstMatch
        let bioField = app.textFields["bioField"].firstMatch
        let signupButton = app.buttons["signupButton"].firstMatch
        
        idField.tap()
        idField.typeText("id")
        
        usernameField.tap()
        usernameField.typeText("username")
        
        passwordField.tap()
        passwordField.typeText("password")
        
        emailField.tap()
        emailField.typeText("email")
        
        genderField.tap()
        genderField.typeText("gender")
        
        creditField.tap()
        creditField.typeText("cerditCard")
        
        bioField.tap()
        bioField.typeText("bio")
        
        signupButton.tap()
    }

}

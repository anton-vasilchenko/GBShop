//
//  RequestFactoryTests.swift
//  GBShopTests
//
//  Created by Антон Васильченко on 19.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class RequestFactoryTests: XCTestCase {
    var requestFactory: RequestFactory?
    
    override func setUpWithError() throws {
         requestFactory = RequestFactory()
    }
    
    override func tearDownWithError() throws {
        requestFactory = nil
    }
    
    func testLogIn() throws {
        let auth = try XCTUnwrap(requestFactory).makeAuthRequestFatory()
        let signedIn = expectation(description: "log in")
        auth.login(userName: "Somebody", password: "pass") { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.user.id, 123)
                signedIn.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testSignUp() throws {
        let signUp = try XCTUnwrap(requestFactory).makeSignUpRequestFactory()
        let signedUp = expectation(description: "signed in")
        signUp.signUp(id: "123",
                      username: "Somebodyy",
                      password: "pass",
                      email: "e@mail.com",
                      gender: "male",
                      creditCard: "123123123",
                      bio: "Some bio") { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.userMessage, "Регистрация прошла успешно!")
                signedUp.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    
    func testLogOut()  throws {
        let logout = try XCTUnwrap(requestFactory).makeLogoutRequestFactory()
        let loggedOut = expectation(description: "Looged out")
        logout.logout(id: "123") { (response) in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                loggedOut.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    

    func testChangeUserData() throws {
        let changeData = try XCTUnwrap(requestFactory).makeChangeUserDataRequestFactory()
        let changedData = expectation(description: "changed user data")
        changeData.changeData(id: "123",
                              username: "Somebodyy",
                              password: "pass",
                              email: "e@mail.com",
                              gender: "male",
                              creditCard: "123123123",
                              bio: "Some bio") { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                changedData.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 10)
    }
    

    
}

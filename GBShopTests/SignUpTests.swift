//
//  SignUpTests.swift
//  GBShopTests
//
//  Created by Антон Васильченко on 19.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class SignUpTests: XCTestCase {
    
    func testLogIn() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        //        let auth = Auth(baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        let signUp = SignUp(baseUrl: baseUrl, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let signedUp = expectation(description: "Signed Up")
        signUp.signUp(id: "123", username: "John", password: "Pass", email: "e@mail.com", gender: "M", creditCard: "123123123", bio: "Some bio") { (response) in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.userMessage, "Регистрация прошла успешно!")
                signedUp.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        //
        //        let loggedIn = expectation(description: "Logged in")
        //        auth.login(userName: "Somebody", password: "pass") { response in
        //            switch response.result {
        //            case .success(let model):
        //                XCTAssertEqual(model.result, 1)
        //                XCTAssertEqual(model.user.login, "geekbrains")
        //                XCTAssertEqual(model.user.name, "John")
        //                XCTAssertEqual(model.user.lastname, "Doe")
        //                XCTAssertEqual(model.user.id, 123)
        //
        //                loggedIn.fulfill()
        //            case .failure(let error):
        //                XCTFail(error.localizedDescription)
        //            }
        //        }
        waitForExpectations(timeout: 10)
    }
    
    func testFailedLogIn() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://some.url"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let signUp = SignUp(baseUrl: baseUrl, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedLogIn = expectation(description: "failed to log in")
        signUp.signUp(id: "123", username: "John", password: "Pass", email: "e@mail.com", gender: "M", creditCard: "123123123", bio: "Some bio") { (response) in
            switch response.result {
            case .success(let model):
                XCTFail("Must have failed: \(model)")
            case .failure:
                failedLogIn.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
        
        
        
    }
    
}

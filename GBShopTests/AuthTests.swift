//
//  AuthTests.swift
//  GBShopTests
//
//  Created by Антон Васильченко on 19.02.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class AuthTests: XCTestCase {

    func testLogIn() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://whispering-waters-74907.herokuapp.com/"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let auth = Auth(baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let loggedIn = expectation(description: "Logged in")
        auth.login(userName: "Somebody", password: "pass") { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.user.login, "geekbrains")
                XCTAssertEqual(model.user.name, "John")
                XCTAssertEqual(model.user.lastname, "Doe")
                XCTAssertEqual(model.user.id, 123)
                
                loggedIn.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testFailedLogIn() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://some.url"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let auth = Auth(baseUrl: baseUrl, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedLogIn = expectation(description: "failed to log in")
        auth.login(userName: "Some", password: "Pass") { response in
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

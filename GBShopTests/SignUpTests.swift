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
        let baseUrl = try XCTUnwrap(URL(string: "https://whispering-waters-74907.herokuapp.com/"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        //        let auth = Auth(baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        let signUp = SignUp(baseUrl: baseUrl, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let signedUp = expectation(description: "Signed Up")
        signUp.signUp(id: 1234, username: "John", password: "Pass", email: "e@mail.com", gender: "M", creditCard: "123123123", bio: "Some bio") { (response) in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.userMessage, "Регистрация прошла успешно!")
                XCTAssertEqual(model.result, 1)
                signedUp.fulfill()
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
        
        let signUp = SignUp(baseUrl: baseUrl, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedLogIn = expectation(description: "failed to log in")
        signUp.signUp(id: 123, username: "John", password: "Pass", email: "e@mail.com", gender: "M", creditCard: "123123123", bio: "Some bio") { (response) in
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

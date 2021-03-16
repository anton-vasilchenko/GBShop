//
//  AddReviewTest.swift
//  GBShopTests
//
//  Created by Антон Васильченко on 04.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class AddReviewTest: XCTestCase {
    
    func testAddReview() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let addReview = AddReview (baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let addedReview = expectation(description: "Review added")
        addReview.addReview(id: 123, reviewText: "Text") { (response) in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.userMessage, "Ваш отзыв был передан на модерацию")
                addedReview.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)

    }
    
    
    
    func testFailedAddReview() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://some.url"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let addReview = AddReview (baseUrl: baseUrl, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedAddedReview = expectation(description: "Review added")
        addReview.addReview(id: 12333, reviewText: "Text") { (response) in
            switch response.result {
            case .success(let model):
                XCTFail("Must have failed: \(model)")
            case .failure:
                failedAddedReview.fulfill()            }
        }
        waitForExpectations(timeout: 10)
        
        
        
    }
    
}

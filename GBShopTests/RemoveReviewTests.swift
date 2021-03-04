//
//  RemoveReviewTests.swift
//  GBShopTests
//
//  Created by Антон Васильченко on 04.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class RemoveReviewTests: XCTestCase {
    
    func testRemoveReview() throws {
        let baseURL = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let removeReview = RemoveReview (baseUrl: baseURL, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let removedReview = expectation(description: "Review added")
        removeReview.removeReview(id: 123) { (response) in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                removedReview.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)

    }
    
    
    
    func testFailedRemovedReview() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://some.url"))
        
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)
        
        let removeReview = RemoveReview (baseUrl: baseUrl, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))
        
        let failedRemovedReview = expectation(description: "Review removed")
        removeReview.removeReview(id: 12333) { (response) in
            switch response.result {
            case .success(let model):
                XCTFail("Must have failed: \(model)")
            case .failure:
                failedRemovedReview.fulfill()            }
        }
        waitForExpectations(timeout: 10)
        
        
        
    }
    
}

//
//  GetGoodByIdTests.swift
//  GBShopTests
//
//  Created by Антон Васильченко on 04.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class GetGoodByIdTests: XCTestCase {

    // MARK: - Positive tests
    
    func testGetGoodById() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)

        let getGoodById = GetGoodById(baseUrl: baseUrl, errorParser: ErrorParser(),
                                      sessionManager: session,
                                      queue: DispatchQueue.global(qos: .utility))

        let gotGoodById = expectation(description: "got good by id")

        getGoodById.getGoodById(id: 123) { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.productName, "Ноутбук")
                XCTAssertEqual(model.productDescription, "Мощный игровой ноутбук")
                XCTAssertEqual(model.productPrice, 45600)
                gotGoodById.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 8.0, handler: nil)
    }

    // MARK: - Negative tests
    
    func testFailedGetGoodById() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://wrong.url.com"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)

        let getGoodById = GetGoodById(baseUrl: baseUrl, errorParser: ErrorParser(),
                                      sessionManager: session,
                                      queue: DispatchQueue.global(qos: .utility))

        let failedGetGoodById = expectation(description: "failed to get good by id")

        getGoodById.getGoodById(id: 123) { response in
            switch response.result {
            case .success(let model):
                XCTFail("Must to have failed: \(model)")
            case .failure:
                failedGetGoodById.fulfill()
            }
        }
        waitForExpectations(timeout: 8.0, handler: nil)
    }
}

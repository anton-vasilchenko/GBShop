//
//  CatalogDataTests.swift
//  GBShopTests
//
//  Created by Антон Васильченко on 04.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class CatalogDataTests: XCTestCase {

    // MARK: - Positive tests
    
    func testCatalogData() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)

        let catalogData = CatalogData(baseUrl: baseUrl, errorParser: ErrorParser(),
                                      sessionManager: session,
                                      queue: DispatchQueue.global(qos: .utility))

        let gotCatalogData = expectation(description: "got catalog data")

        catalogData.getCatalogData(id: 1) { response in
            switch response.result {
            case .success(let model):
                guard let elementFirst: CatalogDataResultElement = model.first else { return }
                guard let elementLast: CatalogDataResultElement = model.last else { return }
                XCTAssertEqual(elementFirst.idProduct, 123)
                XCTAssertEqual(elementFirst.productName, "Ноутбук")
                XCTAssertEqual(elementFirst.price, 45600)
                XCTAssertEqual(elementLast.idProduct, 456)
                XCTAssertEqual(elementLast.productName, "Мышка")
                XCTAssertEqual(elementLast.price, 1000)
                gotCatalogData.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 8.0, handler: nil)
    }

    // MARK: - Negative tests
    
    func testFailedCatalogData() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://wrong.url.com"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)

        let catalogData = CatalogData(baseUrl: baseUrl, errorParser: ErrorParser(),
                                      sessionManager: session,
                                      queue: DispatchQueue.global(qos: .utility))

        let failedCatalogData = expectation(description: "failed to get catalog data")

        catalogData.getCatalogData(id: 1) { response in
            switch response.result {
            case .success(let model):
                XCTFail("Must to have failed: \(model)")
            case .failure:
                failedCatalogData.fulfill()
            }
        }
        waitForExpectations(timeout: 8.0, handler: nil)
    }
}

//
//  PayBasketTests.swift
//  GBShopTests
//
//  Created by Антон Васильченко on 16.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class PayBasketTest: XCTestCase {

    func testPayBasket() throws {
        let baseUrl = AppDelegate.baseUrlHeroku

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)

        let paydBasket = PayBasket(errorParser: ErrorParser(),
                                   sessionManager: session,
                                   queue: DispatchQueue.global(qos: .utility),
                                   baseUrl: baseUrl)

        let payedBasket = expectation(description: "basket was payed")

        paydBasket.payBasket(idPayProve: 1) { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                payedBasket.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    // MARK: - Negative tests

    func testFailedPayBasket() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://wrong.url.com"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)

        let paydBasket = PayBasket(errorParser: ErrorParser(),
                                   sessionManager: session,
                                   queue: DispatchQueue.global(qos: .utility),
                                   baseUrl: baseUrl)

        let failedPaydBasket = expectation(description: "failed to pay basket")

        paydBasket.payBasket(idPayProve: 1) { response in
            switch response.result {
            case .success(let model):
                XCTFail("Must to have failed: \(model)")
            case .failure:
                failedPaydBasket.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }

}


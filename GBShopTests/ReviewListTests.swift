//
//  ReviewListTests.swift
//  GBShopTests
//
//  Created by Антон Васильченко on 16.03.2021.
//

import XCTest
import Alamofire
@testable import GBShop

class ReviewListTest: XCTestCase {

    func testReviewList() throws {
        let baseUrl = AppDelegate.baseUrlHeroku

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)

        let reviewList = ReviewList(baseUrl: baseUrl, errorParser: ErrorParser(), sessionManager: session, queue: DispatchQueue.global(qos: .utility))

        let gotReviewList = expectation(description: "got review list")

        reviewList.reviewList(idUser: 1, pageNumber: "1") { response in
            switch response.result {
            case .success(let model):
                guard let elemrntFirst: ReviewListResultElement = model.first else { return }
                guard let elemrntLast: ReviewListResultElement = model.last else { return }
                XCTAssertEqual(elemrntFirst.idUser, 11122)
                XCTAssertEqual(elemrntFirst.idComment, 1)
                XCTAssertEqual(elemrntFirst.commentText, "Text 1")
                XCTAssertEqual(elemrntLast.idUser, 11122)
                XCTAssertEqual(elemrntLast.idComment, 5)
                XCTAssertEqual(elemrntLast.commentText, "Text 5")
                gotReviewList.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    // MARK: - Negative tests

    func testFailedReviewList() throws {
        let baseUrl = try XCTUnwrap(URL(string: "https://wrong.url.com"))

        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let session = Session(configuration: configuration)

        let reviewList = ReviewList(baseUrl: baseUrl,
                                    errorParser: ErrorParser(),
                                    sessionManager: session,
                                    queue: DispatchQueue.global(qos: .utility))

        let failedGotReviewListt = expectation(description: "failed to get review list")

        reviewList.reviewList(idUser: 1, pageNumber: "1") { response in
            switch response.result {
            case .success(let model):
                XCTFail("Must to have failed: \(model)")
            case .failure:
                failedGotReviewListt.fulfill()
            }
        }
        waitForExpectations(timeout: 10)
    }
}

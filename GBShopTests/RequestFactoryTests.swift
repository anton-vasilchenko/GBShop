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
    
    func testCatalogDataRequestFactory() throws {
        let catalogDataFactory: CatalogDataRequestFactory = try XCTUnwrap(requestFactory).makeCatalogDataRequestFactory()
        let gotCatalogData = expectation(description: "got catalog data")
        catalogDataFactory.getCatalogData(id: 1) { response in
            switch response.result {
            case .success(let model):
                guard let elementFirst: CatalogDataResultElement = model.first else { return }
                guard let elementLast: CatalogDataResultElement = model.last else { return }
                print("\n\(model)\n")
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
        waitForExpectations(timeout: 10)
    }
    
    func testGetGoodByIdRequestFactory() throws {
        let getGoodByIdFactory: GetGoodByIdRequestFactory = try XCTUnwrap(requestFactory).makeGetGoodByIdRequestFactory()
        let gotGoodById = expectation(description: "got good by id")
        getGoodByIdFactory.getGoodById(id: 123) { response in
            switch response.result {
            case .success(let model):
                print("\n\(model)\n")
                XCTAssertEqual(model.result, 1)
                XCTAssertEqual(model.productName, "Ноутбук")
                XCTAssertEqual(model.productDescription, "Мощный игровой ноутбук")
                XCTAssertEqual(model.productPrice, 45600)
                gotGoodById.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testAddRevireRequestFactory() throws {
        let addReviewFactory: AddReviewRequestFactory = try XCTUnwrap(requestFactory).makeAddReviewRequestFactory()
        let addedReviewFactory = expectation(description: "Review added")
        addReviewFactory.addReview(id: 123,reviewText: "Review text") { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                addedReviewFactory.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testRemoveRevireRequestFactory() throws {
        let removeReviewFactory: RemoveReviewRequestFactory = try XCTUnwrap(requestFactory).makeRemoveReviewRequestFactory()
        let removedReviewFactory = expectation(description: "Review removed")
        removeReviewFactory.removeReview(id: 123) { response in
            switch response.result {
            case .success(let model):
                XCTAssertEqual(model.result, 1)
                removedReviewFactory.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        waitForExpectations(timeout: 10)
    }

    
}

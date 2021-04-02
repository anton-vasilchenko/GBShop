//
//  RequestFactory.swift
//  GBShop
//
//  Created by Антон Васильченко on 16.02.2021.
//

import Foundation
import Alamofire

class RequestFactory {
    
    func makeErrorParser() -> AbstractErrorParser {
        return ErrorParser()
    }
    
    lazy var commonSession: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.httpShouldSetCookies = false
        configuration.headers = .default
        let manager = Session(configuration: configuration)
        return manager
    }()
    
    let sessionQueue = DispatchQueue.global(qos: .utility)
    
    func makeAuthRequestFatory() -> AuthRequestFactory {
        let errorParser = makeErrorParser()
        return Auth(errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeSignUpRequestFactory() -> SignUpRequestFactory {
        let errorParcer = makeErrorParser()
        return SignUp(errorParser: errorParcer, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeLogoutRequestFactory() -> LogoutRequestFactory {
        let errorParcer = makeErrorParser()
        return Logout(errorParser: errorParcer, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeChangeUserDataRequestFactory() -> ChangeUserDataRequestFactory {
        let errorParcer = makeErrorParser()
        return ChangeUserData(errorParser: errorParcer, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeCatalogDataRequestFactory() -> CatalogDataRequestFactory {
        let errorParcer = makeErrorParser()
        return CatalogData(errorParser: errorParcer, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeGetGoodByIdRequestFactory() -> GetGoodByIdRequestFactory {
        let errorParcer = makeErrorParser()
        return GetGoodById(errorParser: errorParcer, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeAddReviewRequestFactory() -> AddReviewRequestFactory {
        let errorParcer = makeErrorParser()
        return AddReview(errorParser: errorParcer, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeRemoveReviewRequestFactory() -> RemoveReviewRequestFactory {
        let errorParcer = makeErrorParser()
        return RemoveReview(errorParser: errorParcer, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeReviewListRequestFactory() -> ReviewListRequestFactory {
        let errorParcer = makeErrorParser()
        return ReviewList(errorParser: errorParcer, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeAddToBasketRequestFactory() -> AddToBasketRequestFactory {
        let errorParcer = makeErrorParser()
        return AddToBasket(errorParser: errorParcer, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeDeleteFromBasketRequestFactory() -> DeleteFromBasketRequestFactory {
        let errorParcer = makeErrorParser()
        return DeleteFromBasket(errorParser: errorParcer, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makePayBasketRequestFactory() -> PayBasketRequestFactory {
        let errorParcer = makeErrorParser()
        return PayBasket(errorParser: errorParcer, sessionManager: commonSession, queue: sessionQueue)
    }
}

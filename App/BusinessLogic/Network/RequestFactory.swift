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
    
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!

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
        return Auth(baseUrl: baseUrl, errorParser: errorParser, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeSignUpRequestFactory() -> SignUpRequestFactory {
        let errorParcer = makeErrorParser()
        return SignUp(baseUrl: baseUrl, errorParser: errorParcer, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeLogoutRequestFactory() -> LogoutRequestFactory {
        let errorParcer = makeErrorParser()
        return Logout(baseUrl: baseUrl, errorParser: errorParcer, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeChangeUserDataRequestFactory() -> ChangeUserDataRequestFactory {
        let errorParcer = makeErrorParser()
        return ChangeUserData(baseUrl: baseUrl, errorParser: errorParcer, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeCatalogDataRequestFactory() -> CatalogDataRequestFactory {
        let errorParcer = makeErrorParser()
        return CatalogData(baseUrl: baseUrl, errorParser: errorParcer, sessionManager: commonSession, queue: sessionQueue)
    }
    
    func makeGetGoodByIdRequestFactory() -> GetGoodByIdRequestFactory {
        let errorParcer = makeErrorParser()
        return GetGoodById(baseUrl: baseUrl, errorParser: errorParcer, sessionManager: commonSession, queue: sessionQueue)
    }
}

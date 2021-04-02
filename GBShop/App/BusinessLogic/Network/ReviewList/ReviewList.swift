//
//  ReviewList.swift
//  GBShop
//
//  Created by Антон Васильченко on 16.03.2021.
//

import Foundation
import Alamofire

class ReviewList: AbstractRequestFactory {
    
    // MARK: - Public properties
    
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL
    
    // MARK: - Initializers
    
    init(baseUrl: URL = AppDelegate.baseUrlHeroku,
         errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.baseUrl = baseUrl
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

// MARK: - Extensions ReviewList

extension ReviewList: ReviewListRequestFactory {
    func reviewList(idUser: Int, pageNumber: String, completionHandler: @escaping (AFDataResponse<ReviewListResult>) -> Void) {
        let requestModel = ReviewListRequest(baseUrl: baseUrl, method: .post, idUser: idUser, pageNumber: pageNumber)
        
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ReviewList {
    
    // MARK: Nested type
    
    struct ReviewListRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod
        let path: String = "reviewList"
        
        let idUser: Int
        let pageNumber: String
        
        var parameters: Parameters? {
            [
                "idUser": idUser,
                "pageNumber": pageNumber
            ]
        }
    }
}

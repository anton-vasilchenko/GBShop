//
//  PayBasket.swift
//  GBShop
//
//  Created by Антон Васильченко on 16.03.2021.
//

import Foundation
import Alamofire

class PayBasket: AbstractRequestFactory {

    // MARK: - Public properties

    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL

    // MARK: - Initializers

    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility),
        baseUrl: URL = AppDelegate.baseUrlHeroku
    ) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
        self.baseUrl = baseUrl
    }
}

// MARK: - Extensions PayBasket

extension PayBasket: PayBasketRequestFactory {
    func payBasket(idPayProve: Int, completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void) {
        let requestModel = PayBasketRequest(baseUrl: baseUrl, idPayProve: idPayProve)

        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension PayBasket {

    // MARK: Nested type

    struct PayBasketRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "payBasket"

        let idPayProve: Int

        var parameters: Parameters? {
            [ "idPayProve": idPayProve ]
        }
    }
}

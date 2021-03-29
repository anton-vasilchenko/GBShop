//
//  DeleteFromBasket.swift
//  GBShop
//
//  Created by Антон Васильченко on 08.03.2021.
//

import Foundation
import Alamofire

class DeleteFromBasket: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl: URL
//    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!
    
    init(baseUrl: URL = AppDelegate.baseUrlGitGB,
         errorParser: AbstractErrorParser,
         sessionManager: Session,
         queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.baseUrl = baseUrl
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension DeleteFromBasket: DeleteFromBasketRequestFactory {
    func deleteFromBasket(id: Int, completionHandler: @escaping (AFDataResponse<DeleteFromBasketResult>) -> Void) {
        let requestModel = DeleteFromBasketRequest(baseUrl: baseUrl, method: .get, id: id)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension DeleteFromBasket {

    struct DeleteFromBasketRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod
        let path: String = "addToBasket.json"

        let id: Int

        var parameters: Parameters? {
            ["id_product": id]
        }
    }
}

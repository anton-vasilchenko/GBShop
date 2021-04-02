//
//  ChangeUserData.swift
//  GBShop
//
//  Created by Антон Васильченко on 19.02.2021.
//

import Foundation
import Alamofire

class ChangeUserData: AbstractRequestFactory {
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

extension ChangeUserData: ChangeUserDataRequestFactory {

    func changeData(id: String,
                    username: String,
                    password: String,
                    email: String,
                    gender: String,
                    creditCard: String,
                    bio: String,
                    completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void) {
        let requestModel = ChangeUserDataRequest(
            baseUrl: baseUrl,
            method: .get,
            id: id,
            username: username,
            password: password,
            email: email,
            gender: gender,
            creditCard: creditCard,
            bio: bio
        )
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension ChangeUserData {
    struct ChangeUserDataRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod
        let path: String = "changeUserData.json"
        
        let id: String
        let username: String
        let password: String
        let email: String
        let gender: String
        let creditCard: String
        let bio: String
        var parameters: Parameters? {
            return [
                "id_user": id,
                "username": username,
                "password": password,
                "email": email,
                "gender": gender,
                "credit_card": creditCard,
                "bio": bio
                
            ]
        }
    }
}

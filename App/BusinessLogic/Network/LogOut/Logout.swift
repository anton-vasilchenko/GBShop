//
//  Logout.swift
//  GBShop
//
//  Created by Антон Васильченко on 19.02.2021.
//

import Foundation
import Alamofire

class Logout: AbstractRequestFactory {
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

extension Logout: LogoutRequestFactory {
    func logout(id: String, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void) {
        let requestModel = LogoutApp(baseUrl: baseUrl, id: id)
        self.request(request: requestModel, completionHandler: completionHandler)
        
    }
    
}

extension Logout {
    struct LogoutApp: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "logout.json"
        
        let id: String
        var parameters: Parameters? {
            return ["id_user": id]
        }
    }
}

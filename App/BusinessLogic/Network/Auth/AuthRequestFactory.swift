//
//  AuthRequestFactory.swift
//  GBShop
//
//  Created by Антон Васильченко on 16.02.2021.
//

import Foundation
import Alamofire

protocol AuthRequestFactory {
    func login(userName: String, password: String, completionHandler: @escaping (AFDataResponse<LoginResult>) -> Void)
}

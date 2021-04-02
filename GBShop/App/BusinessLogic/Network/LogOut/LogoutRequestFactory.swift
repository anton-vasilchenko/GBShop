//
//  LogoutRequestFactory.swift
//  GBShop
//
//  Created by Антон Васильченко on 19.02.2021.
//

import Foundation
import Alamofire

protocol LogoutRequestFactory {
    func logout(id: String, completionHandler: @escaping (AFDataResponse<LogoutResult>) -> Void)
}

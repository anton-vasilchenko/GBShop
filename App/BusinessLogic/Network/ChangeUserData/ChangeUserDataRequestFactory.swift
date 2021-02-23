//
//  ChangeUserDataRequestFactory.swift
//  GBShop
//
//  Created by Антон Васильченко on 19.02.2021.
//

import Foundation
import Alamofire

protocol ChangeUserDataRequestFactory {
    func changeData(id: String, username: String, password: String, email: String, gender: String, creditCard: String, bio: String, completionHandler: @escaping (AFDataResponse<ChangeUserDataResult>) -> Void)

}


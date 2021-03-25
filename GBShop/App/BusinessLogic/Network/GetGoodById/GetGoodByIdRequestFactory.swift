//
//  GetGoodByIdRequestFactory.swift
//  GBShop
//
//  Created by Антон Васильченко on 04.03.2021.
//

import Foundation
import Alamofire

protocol GetGoodByIdRequestFactory {
    func getGoodById(id: Int, completionHandler: @escaping (AFDataResponse<GetGoodByIdResult>) -> Void)
}

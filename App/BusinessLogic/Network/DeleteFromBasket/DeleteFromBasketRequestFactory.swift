//
//  DeleteFromBasketRequestFactory.swift
//  GBShop
//
//  Created by Антон Васильченко on 08.03.2021.
//

import Foundation
import Alamofire

protocol DeleteFromBasketRequestFactory {
    func addToBasket(id: Int, completionHandler: @escaping (AFDataResponse<AddToBasketResult>) -> Void)
}

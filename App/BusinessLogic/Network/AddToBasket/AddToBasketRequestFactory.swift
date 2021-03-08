//
//  AddToBasketRequestFactory.swift
//  GBShop
//
//  Created by Антон Васильченко on 08.03.2021.
//

import Foundation
import Alamofire

protocol AddToBasketRequestFactory {
    func addToBasket(id: Int, quantity: Int, completionHandler: @escaping (AFDataResponse<AddToBasketResult>) -> Void)
}

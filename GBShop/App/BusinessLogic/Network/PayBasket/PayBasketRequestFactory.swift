//
//  PayBasketRequestFactory.swift
//  GBShop
//
//  Created by Антон Васильченко on 16.03.2021.
//

import Foundation
import Alamofire

protocol PayBasketRequestFactory {
    func payBasket(idPayProve: Int, completionHandler: @escaping (AFDataResponse<PayBasketResult>) -> Void)
}

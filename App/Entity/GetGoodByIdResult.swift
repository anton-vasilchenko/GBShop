//
//  GetGoodByIdResult.swift
//  GBShop
//
//  Created by Антон Васильченко on 04.03.2021.
//

import Foundation

struct GetGoodByIdResult: Codable {
    let result: Int
    let productName: String
    let productPrice: Int
    let productDescription: String

    enum CodingKeys: String, CodingKey {
        case result
        case productName = "product_name"
        case productPrice = "product_price"
        case productDescription = "product_description"
    }
}

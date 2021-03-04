//
//  CatalogDataResult.swift
//  GBShop
//
//  Created by Антон Васильченко on 04.03.2021.
//

import Foundation

struct CatalogDataResultElement: Codable {
    let idProduct: Int
    let productName: String
    let price: Int

    enum CodingKeys: String, CodingKey {
        case idProduct = "id_product"
        case productName = "product_name"
        case price
    }
}

typealias CatalogDataResult = [CatalogDataResultElement]

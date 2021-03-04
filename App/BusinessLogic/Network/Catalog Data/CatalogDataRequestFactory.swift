//
//  CatalogDataRequestFactory.swift
//  GBShop
//
//  Created by Антон Васильченко on 04.03.2021.
//

import Foundation
import Alamofire

protocol CatalogDataRequestFactory {
    func getCatalogData(id: Int, completionHandler: @escaping (AFDataResponse<CatalogDataResult>) -> Void)
}

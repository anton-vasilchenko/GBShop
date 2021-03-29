//
//  ReviewListRequestFactory.swift
//  GBShop
//
//  Created by Антон Васильченко on 16.03.2021.
//

import Foundation
import Alamofire

protocol ReviewListRequestFactory {
    func reviewList(idUser: Int, pageNumber: String, completionHandler: @escaping (AFDataResponse<ReviewListResult>) -> Void)
}

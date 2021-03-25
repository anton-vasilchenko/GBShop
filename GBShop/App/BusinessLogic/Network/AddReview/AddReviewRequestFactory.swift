//
//  AddReviewRequestFactory.swift
//  GBShop
//
//  Created by Антон Васильченко on 04.03.2021.
//

import Foundation
import Alamofire

protocol AddReviewRequestFactory {
    func addReview(id: Int, reviewText: String, completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void)
}

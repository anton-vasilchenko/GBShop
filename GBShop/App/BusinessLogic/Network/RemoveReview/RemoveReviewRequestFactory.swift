//
//  RemoveReviewRequestFactory.swift
//  GBShop
//
//  Created by Антон Васильченко on 04.03.2021.
//

import Foundation
import Alamofire

protocol RemoveReviewRequestFactory {
    func removeReview(id: Int, completionHandler: @escaping (AFDataResponse<RemoveReviewResult>) -> Void)
}

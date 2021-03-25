//
//  ReviewListResult.swift
//  GBShop
//
//  Created by Антон Васильченко on 16.03.2021.
//

import Foundation

struct ReviewListResultElement: Codable {
    let idUser: Int
    let idComment: Int
    let commentText: String
}

typealias ReviewListResult = [ReviewListResultElement]

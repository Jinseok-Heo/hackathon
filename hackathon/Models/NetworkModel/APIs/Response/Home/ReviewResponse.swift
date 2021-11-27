//
//  Review.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/27.
//

import Foundation

typealias Reviews = [Review]

struct Review: Codable, Hashable {
    let nickName, rating, reviewID, content: String
    let matchingID: String
    
    enum CodingKeys: String, CodingKey {
        case nickName, rating
        case reviewID = "reviewId"
        case content
        case matchingID = "matchingId"
    }
}

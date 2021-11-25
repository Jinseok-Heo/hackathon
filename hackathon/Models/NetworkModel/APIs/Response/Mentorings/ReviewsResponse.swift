//
//  ReviewsResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import Foundation

struct ReviewsResponse: Identifiable, Codable {
    
    let id: Int
    let matchingId: Int
    let rating: Int
    let contents: String
    
    enum CodingKeys: String, CodingKey {
        case id, rating, contents
        case matchingId = "matching_id"
    }
    
}

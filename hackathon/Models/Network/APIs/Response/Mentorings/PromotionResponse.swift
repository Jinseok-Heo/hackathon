//
//  PromotionResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import Foundation

struct PromotionResponse: Identifiable, Codable {
    
    let id: Int
    let mentoId: Int
    let title: String
    let description: String
    let price: Int
    let imageId: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, price
        case mentoId = "mento_id"
        case imageId = "image_id"
    }
    
}

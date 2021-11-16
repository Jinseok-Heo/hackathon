//
//  MentoResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import Foundation

struct MentoResponse: Identifiable, Codable {
    
    let id: Int
    let userId: Int
    let isVerifed: Bool
    let years: Int
    
    enum CodingKeys: String, CodingKey {
        case id, years
        case userId = "user_id"
        case isVerifed = "verified"
    }
    
}

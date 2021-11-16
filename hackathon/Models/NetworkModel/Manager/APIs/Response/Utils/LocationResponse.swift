//
//  LocationResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import SwiftUI

struct LocationResponse: Identifiable, Codable {
    
    let id: Int
    let userId: Int
    let latitude: Double
    let longitude: Double
    let local: String
    
    enum CodingKeys: String, CodingKey {
        case id, latitude, longitude, local
        case userId = "user_id"
    }
    
}

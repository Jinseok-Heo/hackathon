//
//  AuthResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import Foundation

// MARK: Auth API response
struct AuthResponse: Codable {
    
    let verifiedToken: String
    let refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case verifiedToken = "verified-token"
        case refreshToken = "refresh-token"
    }
    
}

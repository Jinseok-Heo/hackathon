//
//  AuthResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import Foundation

// MARK: Auth API response
struct AuthResponse: Codable {
    
    var user: UserResponse
    var token: TokenResponse
    
    enum CodingKeys: String, CodingKey {
        case user
        case token
    }
    
}

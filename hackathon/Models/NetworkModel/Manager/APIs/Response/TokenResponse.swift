//
//  TokenResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import Foundation

struct TokenResponse: Codable {
    
    let accessToken: String
    let refreshToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken
        case refreshToken
    }
}

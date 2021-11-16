//
//  UserResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

// MARK: User API Response
struct UserResponse: Identifiable, Codable {
    
    let id: Int
    let name: String
    let mailAddress: String
    let password: String
    let isVerified: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name, password
        case mailAddress = "email"
        case isVerified = "verified"
    }
    
}

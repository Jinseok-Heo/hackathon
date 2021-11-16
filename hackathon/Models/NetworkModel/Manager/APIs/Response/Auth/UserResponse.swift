//
//  UserResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

struct UserResponse: Identifiable, Codable {
    
    let id: Int
    let name: String
    let mailAddress: String
    let password: String
    let schoolName: String
    let major: String
    let isVerified: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case mailAddress = "email"
        case password
        case isVerified = "verified"
    }
    
}

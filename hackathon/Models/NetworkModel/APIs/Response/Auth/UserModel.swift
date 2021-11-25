//
//  UserResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

struct UserResponse: Codable {
    
    let nickName: String
    let profileImage: String
    let verified: Bool
    
    enum CodingKeys: String, CodingKey {
        case nickName, profileImage, verified
    }
}

struct UserModel: Identifiable {
    
    let id: String
    let nickName: String
    let profileImage: UIImage?
    let verified: Bool
    
    static var user: UserModel? = nil
    
    static func getUser() -> UserModel? {
        return user
    }
    
    static func saveUser(user: UserModel) {
        self.user = user
    }
    
}

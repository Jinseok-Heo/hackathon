//
//  ProfileResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import SwiftUI

struct ProfileResponse: Identifiable, Codable {
    
    let id: Int
    let userId: Int
    let nickName: String
    let gender: Gender?
    let birth: Date?
    let company: String?
    let job: String?
    let school: String?
    let major: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case nickName = "nickname"
        case gender
        case birth
        case company
        case job
        case school
        case major
    }
    
}
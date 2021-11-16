//
//  UserResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

struct UserResponse: Identifiable, Codable {
    
    let id: String = UUID().uuidString
    let name: String
    let displayName: String
    let gender: String
    let mailAddress: String
    let schoolName: String
    let major: String
    let isVerified: Bool
    let isMentor: Bool
    let profileImageURL: String?
    let intro: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case displayName = "display_name"
        case gender
        case mailAddress = "mail_address"
        case schoolName = "school_name"
        case major
        case isVerified = "is_verified"
        case isMentor = "is_mentor"
        case profileImageURL = "profile_image"
        case intro
    }
    
    init(name: String,
         displayName: String,
         gender: String,
         mailAddress: String,
         schoolName: String,
         major: String,
         isVerified: Bool,
         isMentor: Bool,
         profileImageURL: String?,
         intro: String?
    ) {
        self.name = name
        self.displayName = displayName
        self.gender = gender
        self.mailAddress = mailAddress
        self.schoolName = schoolName
        self.major = major
        self.isVerified = isVerified
        self.isMentor = isMentor
        self.profileImageURL = profileImageURL
        self.intro = intro
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.displayName = try container.decode(String.self, forKey: .displayName)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.mailAddress = try container.decode(String.self, forKey: .mailAddress)
        self.schoolName = try container.decode(String.self, forKey: .schoolName)
        self.major = try container.decode(String.self, forKey: .major)
        self.isVerified = try container.decode(Bool.self, forKey: .isVerified)
        self.isMentor = try container.decode(Bool.self, forKey: .isMentor)
        self.profileImageURL = try container.decode(String?.self, forKey: .profileImageURL)
        self.intro = try container.decode(String?.self, forKey: .intro)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(displayName, forKey: .displayName)
        try container.encode(gender, forKey: .gender)
        try container.encode(mailAddress, forKey: .mailAddress)
        try container.encode(schoolName, forKey: .schoolName)
        try container.encode(major, forKey: .major)
        try container.encode(isVerified, forKey: .isVerified)
        try container.encode(isMentor, forKey: .isMentor)
        try container.encode(profileImageURL, forKey: .profileImageURL)
        try container.encode(intro, forKey: .intro)
    }
    
}

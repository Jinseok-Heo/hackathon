//
//  MatchingResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import Foundation

struct MatchingResponse: Identifiable, Codable {
    
    let id: Int
    let mentorId: Int
    let menteeId: Int
    let untact: Bool
    let time: Date
    
    enum CodingKeys: String, CodingKey {
        case id, untact, time
        case mentorId = "mentor_id"
        case menteeId = "mentee_id"
    }
}

struct Mento: Codable, Identifiable {
    let id: String
    let menteeId: String
    let nickName: String
    let profileImage: String
    let content, preferredLocation: String
    let untact: String
    
    enum CodingKeys: String, CodingKey {
        case menteeId = "mentee_id"
        case id, nickName, profileImage, content, preferredLocation, untact
    }
}

struct Mentee: Codable {
    let createdDateTime: Date?
    let id: Int
    let userName, email, password: String?
}

typealias Mentos = [Mento]

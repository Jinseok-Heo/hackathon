//
//  MentoResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/27.
//

import Foundation

typealias Mentos = [Mento]

struct Mento: Codable, Identifiable {
    let menteeID, nickName, rating, id: String
    let profileImage, untact, content, preferredLocation: String

    enum CodingKeys: String, CodingKey {
        case menteeID = "mentee_id"
        case nickName, rating, id, profileImage, untact, content, preferredLocation
    }
}

struct Mentee: Codable {
    let createdDateTime: Date?
    let id: Int
    let userName, email, password: String?
}

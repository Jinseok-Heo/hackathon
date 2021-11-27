//
//  RecommendReponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/27.
//

import Foundation

typealias  Recommends = [Recommend]

struct Recommend: Codable, Identifiable {
    let id: String = UUID().uuidString
    let nickName, rating, mentoID, job, year: String
    let profileImage: String

    enum CodingKeys: String, CodingKey {
        case nickName, rating, job, year, profileImage
        case mentoID = "mentoId"
    }
}

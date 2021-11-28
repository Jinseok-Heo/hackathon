//
//  MatchingResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import Foundation
import UIKit

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


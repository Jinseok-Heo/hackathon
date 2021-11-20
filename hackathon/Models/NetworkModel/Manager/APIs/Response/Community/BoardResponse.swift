//
//  BoardResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import Foundation

struct BoardResponse: Identifiable, Codable {
    
    let id: Int
    let title: String
    let content: String
    let writerId: Int
    let createdDate: Date
    let edited: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, edited, title, content
        case writerId = "writer"
        case createdDate = "created_date"
    }
    
}

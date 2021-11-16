//
//  CommentResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import Foundation

struct CommentResponse: Identifiable, Codable {
    let id: Int
    let boardId: Int
    let writerId: Int
    let createdDate: Date
    let edited: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, edited
        case boardId = "board_id"
        case writerId = "writer"
        case createdDate = "created_date"
    }
}

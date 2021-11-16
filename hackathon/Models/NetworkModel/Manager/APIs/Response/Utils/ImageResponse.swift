//
//  ImageResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import Foundation

struct ImageResponse: Identifiable, Codable {
    
    let id: Int
    let fillSize: Double
    let name: String
    let path: String
    
    enum CodingKeys: String, CodingKey {
        case id, name, path
        case fillSize = "fill_size"
    }
    
}

//
//  PreferredJobResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import SwiftUI

struct PreferredJobResponse: Identifiable, Codable {
    
    let id: Int
    let userId: Int
    let jobName: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case jobName = "job_name"
    }
    
}

//
//  PreferredCompanyResponse.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import Foundation

struct PreferredCompanyResponse: Identifiable, Codable {
    let id: Int
    let userId: Int
    let companyName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case companyName = "company_name"
    }
}

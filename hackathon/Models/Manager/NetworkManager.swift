//
//  NetworkManager.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/25.
//

import Foundation

class NetworkManager {

    static let base: String = "http://localhost:8888"
//    static let base: String = "https://a0b9-121-141-119-67.ngrok.io"
    static let session = APIClient.shared.session
    
}

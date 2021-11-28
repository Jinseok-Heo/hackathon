//
//  HomeRouter.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/27.
//

import Foundation
import Alamofire

enum HomeRouter: URLRequestConvertible {
    
    case getList
    case getSchedule(userId: String)

    var endPoint: String {
        switch self {
        case .getList:
            return "/app/home/recommend"
        case .getSchedule(let userId):
            return "/app/home/schedule/\(userId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getList:
            return .post
        case .getSchedule:
            return .get
        }
    }

    
    func asURLRequest() throws -> URLRequest {
        let urlString = NetworkManager.base + endPoint
        let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedUrl)!
        var request = URLRequest(url: url)
        request.method = method
        request.httpBody = try JSONEncoding.default.encode(request, with: nil).httpBody
        return request
    }

}




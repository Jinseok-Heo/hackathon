//
//  MentoRouter.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/24.
//

import Foundation
import Alamofire
import CoreLocation

enum MentoRouter: URLRequestConvertible {
    
    case register(email: String,
                  content: String,
                  preferredLocation: CLLocationCoordinate2D,
                  untact: Bool,
                  userId: String)
    case authenticate(email: String)
    
    static let base: String = "http://localhost:8888"
    
    var endPoint: String {
        switch self {
        case .register:
            return "/user/mento/register"
        case .authenticate:
            return "/user/mento/email"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .register:
            return .post
        case .authenticate:
            return .post
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .register(email, content, preferredLoc, untact, userId):
            var params = Parameters()
            params["userId"] = userId
            params["email"] = email
            params["content"] = content
            params["preferredLoc"] = preferredLoc.toDictionary()
            params["untact"] = untact
            return params
        case let .authenticate(email):
            var params = Parameters()
            params["email"] = email
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlString = AuthRouter.base + endPoint
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.method = method
        switch method {
        case .get:
            request.httpBody = try URLEncoding.default.encode(request, with: nil).httpBody
        default:
            request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
        }
        return request
    }

}


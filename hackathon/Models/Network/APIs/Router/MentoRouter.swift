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
    
    case getMentoList
    case register(content: String,
                  preferredLocation: String,
                  untact: Bool,
                  userId: String)
    case sendEmail(email: String)
    case authenticate(passcode: String)
        
    var endPoint: String {
        switch self {
        case .getMentoList:
            return "/app/mentolist"
        case let .register(content, preferredLocation, untact, userId):
            return "/app/user/mento/register?userId=\(userId)&preferredLocation=\(preferredLocation)&untact=\(untact.description)&content=\(content)"
        case .sendEmail:
            return "/verify/email"
        case .authenticate:
            return "/verify/verifycode"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .register:
            return .get
        case .sendEmail, .authenticate, .getMentoList:
            return .post
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .register(content, preferredLocation, untact, userId):
            var params = Parameters()
            params["userId"] = userId
            params["content"] = content
            params["preferredLocation"] = preferredLocation
            params["untact"] = untact
            return params
        case let .sendEmail(email):
            var params = Parameters()
            params["email"] = email
            return params
        case let .authenticate(passcode):
            var params = Parameters()
            params["userId"] = SecurityManager.shared.load(account: .userID)
            params["code"] = passcode
            return params
        default:
            return Parameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlString = NetworkManager.base + endPoint
        let encodedUrl = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedUrl)!
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


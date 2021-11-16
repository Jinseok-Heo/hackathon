//
//  AuthRouter.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import Foundation
import Alamofire

enum AuthRouter: URLRequestConvertible {
    
case register(email: String,
              password: String,
              name: String,
              displayName: String,
              gender: Gender,
              school: String,
              major: String,
              intro: String?)
case login(email: String, password: String)
case tokenRefresh

    var baseURL: URL {
        return URL(string: "base url goes here")!
    }
    
    var endPoint: String {
        switch self {
        case .register:
            return "Register url goes here"
        case .login:
            return "Login url goes here"
        case .tokenRefresh:
            return "Token refresh goes here"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        default: return .post
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .login(email, password):
            var params = Parameters()
            params["email"] = email
            params["password"] = password
            return params
        case let .register(email, password, name, displayName, gender, school, major, intro):
            var params = Parameters()
            params["email"] = email
            params["password"] = password
            params["name"] = name
            params["displayName"] = displayName
            params["gender"] = gender.rawValue
            params["school"] = school
            params["major"] = major
            params["intro"] = intro
            return params
        case .tokenRefresh:
            var params = Parameters()
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        
        var request = URLRequest(url: url)
        
        request.method = method
        request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
        
        return request
    }

}


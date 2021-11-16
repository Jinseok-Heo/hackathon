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
              userName: String,
              nickName: String,
              gender: Gender,
              birth: String,
              company: String,
              job: String,
              year: Int,
              school: String,
              major: String)
case login(userName: String, password: String)
case tokenRefresh

    var baseURL: URL {
        return URL(string: "http://685f-211-58-223-157.ngrok.io")!
    }
    
    var endPoint: String {
        switch self {
        case .register:
            return "/login/register"
        case .login:
            return "/login"
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
        case let .login(userName, password):
            var params = Parameters()
            params["userName"] = userName
            params["password"] = password
            return params
        case let .register(email, password, userName, nickName, gender, birth, company, job, year, school, major):
            var params = Parameters()
            params["email"] = email
            params["password"] = password
            params["userName"] = userName
            params["nickName"] = nickName
            params["gender"] = gender.rawValue
            params["birth"] = birth
            params["company"] = company
            params["job"] = job
            params["year"] = year
            params["school"] = school
            params["major"] = major
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


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
              gender: String,
              birth: String,
              company: String?,
              job: String?,
              year: Int?,
              school: String,
              major: String)
case login(userName: String, password: String)

    var baseURL: URL {
        return URL(string: "http://4424-121-141-119-67.ngrok.io")!
    }
    
    var endPoint: String {
        switch self {
        case .register:
            return "/user/register"
        case .login:
            return "/user/login"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login:
            return .get
        case .register:
            return .post
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .login(userName, password):
            var params = Parameters()
            params["username"] = userName
            params["password"] = password
            return params
        case let .register(email, password, userName, nickName, gender, birth, company, job, year, school, major):
            var params = Parameters()
            params["email"] = email
            params["password"] = password
            params["username"] = userName
            params["nickname"] = nickName
            params["gender"] = gender
            params["birth"] = birth
            params["company"] = company
            params["job"] = job
            params["year"] = year
            params["school"] = school
            params["major"] = major
            return params
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(endPoint)
        
        var request = URLRequest(url: url)
        
        request.method = method
        switch method {
        case .get:
            request.httpBody = try URLEncoding.default.encode(request, with: parameters).httpBody
        case .post:
            request.httpBody = try JSONEncoding.default.encode(request, with: parameters).httpBody
        default:
            request.httpBody = try URLEncoding.default.encode(request, with: parameters).httpBody
        }
        return request
    }

}


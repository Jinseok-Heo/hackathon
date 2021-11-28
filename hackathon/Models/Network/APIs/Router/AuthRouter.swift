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
case getProfile(userId: String)
case refreshToken
case logout
    
    var endPoint: String {
        switch self {
        case .register:
            return "/user/register"
        case let .login(username, password):
            return "/user/login?username=\(username)&password=\(password)"
        case .refreshToken:
            return "/user/refresh"
        case .getProfile(let userId):
            return "/app/user/profile/short/\(userId)"
        case .logout:
            let access = SecurityManager.shared.load(account: .accessToken)!
            let refresh = SecurityManager.shared.load(account: .refreshToken)!
            return "/user/logout/?token=\(access)&refreshToken=\(refresh)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .login, .logout:
            return .get
        case .register, .getProfile, .refreshToken:
            return .post
        }
    }
    
    var parameters: Parameters {
        switch self {
        case let .register(email, password, userName, nickName, gender, birth, company, job, year, school, major):
            var params = Parameters()
            params["email"] = email
            params["password"] = password
            params["username"] = userName
            params["nickname"] = nickName
            params["gender"] = gender
            params["birth"] = birth
            if company != nil {
                params["company"] = company
            }
            if job != nil {
                params["job"] = job
            }
            params["year"] = year ?? 0
            params["school"] = school
            params["major"] = major
            return params
        case .refreshToken:
            var params = Parameters()
            params["userId"] = SecurityManager.shared.load(account: .userID)!
            params["refreshToken"] = SecurityManager.shared.load(account: .refreshToken)!
            return params
        default:
            return Parameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlString = NetworkManager.base + endPoint
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


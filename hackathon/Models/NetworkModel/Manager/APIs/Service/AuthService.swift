//
//  AuthService.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import Foundation
import Alamofire
import Combine

enum AuthAPIService {
    
    static func login(userName: String, password: String, completion: @escaping (AFDataResponse<Any>) -> () ) {
        let encodedPassword = password.toBase64()
        let url = "https://a24c-121-141-119-67.ngrok.io/user/login?username=\(userName)&password=\(encodedPassword)"
        print(url)
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (json) in
                print(json.response?.allHeaderFields)
            }
//        APIClient.shared.session
//            .request(AuthRouter.login(userName: userName, password: password))
//            .responseJSON(completionHandler: completion)
    }
    
    static func register(email: String,
                         password: String,
                         userName: String,
                         nickName: String,
                         gender: String,
                         birth: String,
                         company: String?,
                         job: String?,
                         year: Int?,
                         school: String,
                         major: String,
    completion: @escaping (AFDataResponse<Any>) -> () ) {
        APIClient.shared.session
            .request(AuthRouter.register(email: email,
                                         password: password,
                                         userName: userName,
                                         nickName: nickName,
                                         gender: gender,
                                         birth: birth,
                                         company: company,
                                         job: job,
                                         year: year,
                                         school: school,
                                         major: major))
            .responseJSON(completionHandler: completion)
    }
}

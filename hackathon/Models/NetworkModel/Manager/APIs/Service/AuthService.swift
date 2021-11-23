//
//  AuthService.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import Foundation
import Alamofire

enum AuthAPIService {
    
    static func login(userName: String, password: String, completion: @escaping (AFDataResponse<Any>) -> () ) {
        APIClient.shared.session
            .request(AuthRouter.login(userName: userName, password: password))
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: completion)
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
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: completion)
    }
}

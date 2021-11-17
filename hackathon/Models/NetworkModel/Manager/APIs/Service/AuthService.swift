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
    
    static func login(userName: String, password: String) -> AnyPublisher<UserResponse, AFError> {
        print("AuthAPIService - login() called")
        
        return APIClient.shared.session
            .request(AuthRouter.login(userName: userName, password: password))
            .publishDecodable(type: AuthResponse.self)
            .value()
            .map { value in
                UserDefaultsManager.shared.setTokens(accessToken: value.token.accessToken,
                                                     refreshToken: value.token.refreshToken)
                return value.user
            }.eraseToAnyPublisher()
    }
    
    static func register(email: String,
                         password: String,
                         userName: String,
                         nickName: String,
                         gender: String,
                         birth: String,
                         company: String,
                         job: String,
                         year: Int,
                         school: String,
                         major: String
    ) -> AnyPublisher<UserResponse, AFError> {
        print("AuthAPIService - register() called")
        
        return APIClient.shared.session
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
            .publishDecodable(type: AuthResponse.self)
            .value()
            .map { value in
                UserDefaultsManager.shared.setTokens(accessToken: value.token.accessToken,
                                                     refreshToken: value.token.refreshToken)
                return value.user
            }.eraseToAnyPublisher()
    }
}

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
    
    static func login(email: String, password: String) -> AnyPublisher<UserResponse, AFError> {
        print("AuthAPIService - login() called")
        
        return APIClient.shared.session
            .request(AuthRouter.login(email: email, password: password))
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
                         name: String,
                         displayName: String,
                         gender: Gender,
                         school: String,
                         major: String,
                         intro: String?
    ) -> AnyPublisher<UserResponse, AFError> {
        print("AuthAPIService - register() called")
        
        return APIClient.shared.session
            .request(AuthRouter.register(email: email, password: password, name: name, displayName: displayName, gender: gender, school: school, major: major, intro: intro))
            .publishDecodable(type: AuthResponse.self)
            .value()
            .map { value in
                UserDefaultsManager.shared.setTokens(accessToken: value.token.accessToken,
                                                     refreshToken: value.token.refreshToken)
                return value.user
            }.eraseToAnyPublisher()
    }
}

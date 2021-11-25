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
        NetworkManager.session
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
        NetworkManager.session
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
    
    static func getProfile(userId: String) -> AnyPublisher<UserModel, AFError> {
        NetworkManager.session
            .request(AuthRouter.getProfile(userId: userId))
            .validate(statusCode: 200..<300)
            .publishDecodable(type: UserResponse.self)
            .value()
            .map { rawUser in
                let imageData = Data(base64Encoded: rawUser.profileImage)
                if let imageData = imageData {
                    let image = UIImage(data: imageData)
                    return UserModel(id: UUID().uuidString, nickName: rawUser.nickName, profileImage: image, verified: rawUser.verified)
                } else {
                    return UserModel(id: UUID().uuidString, nickName: rawUser.nickName, profileImage: UIImage(named: "userPlaceholder"), verified: rawUser.verified)
                }
            }
            .eraseToAnyPublisher()
    }
    
    static func refreshToken(completion: @escaping (AFDataResponse<Any>) -> () ) {
        NetworkManager.session
            .request(AuthRouter.refreshToken)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: completion)
    }
    
    static func logout(completion: @escaping (AFDataResponse<Any>) -> () ) {
        NetworkManager.session
            .request(AuthRouter.logout)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: completion)
    }
    
}

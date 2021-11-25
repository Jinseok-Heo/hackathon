//
//  MatchingAPIService.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/25.
//

import Foundation
import Alamofire
import Combine

enum MatchingAPIService {
    
    static func getList() -> AnyPublisher<Mentos, AFError> {
        NetworkManager.session
            .request(MatchingRouter.getList)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: Mentos.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    static func matching(menteeId: String,
                         mentoId: String,
                         location: String?,
                         appointmentTime: Date,
                         completion: @escaping (AFDataResponse<Any>) -> () ) {
        NetworkManager.session
            .request(MatchingRouter.matching(menteeId: menteeId, mentoId: mentoId, location: location, appointmentTime: appointmentTime))
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: completion)
    }
    
    static func postReview(rating: Int,
                           matchingId: String,
                           mentoId: String,
                           content: String,
                           completion: @escaping (AFDataResponse<Any>) -> () ) {
        NetworkManager.session
            .request(MatchingRouter.postReview(rating: rating, matchingId: matchingId, mentoId: mentoId, content: content))
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: completion)
    }
    
    static func reviewDetail(mentoId: String, completion: @escaping (AFDataResponse<Any>) -> () ) {
        NetworkManager.session
            .request(MatchingRouter.getMentoReview(mentoId: mentoId))
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: completion)
    }
    
    static func getProfile() -> AnyPublisher<UserModel, AFError> {
        NetworkManager.session
            .request(AuthRouter.getProfile(userId: SecurityManager.shared.load(account: .userID)!))
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
    
}

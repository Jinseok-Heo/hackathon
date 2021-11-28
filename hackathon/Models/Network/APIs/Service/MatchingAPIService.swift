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
    
    static func reviewDetail(mentoId: String) -> AnyPublisher<Reviews, AFError> {
        NetworkManager.session
            .request(MatchingRouter.getMentoReview(mentoId: mentoId))
            .validate(statusCode: 200..<300)
            .publishDecodable(type: Reviews.self)
            .value()
            .eraseToAnyPublisher()
    }
    
}

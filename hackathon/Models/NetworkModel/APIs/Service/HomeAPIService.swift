//
//  HomeAPIService.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/27.
//

import Foundation
import Alamofire
import Combine

enum HomeAPIService {
    
    static func getList() -> AnyPublisher<Recommends, AFError> {
        NetworkManager.session
            .request(HomeRouter.getList)
            .validate(statusCode: 200..<300)
            .publishDecodable(type: Recommends.self)
            .value()
            .eraseToAnyPublisher()
    }
//    static func getList(completion: @escaping (AFDataResponse<Any>) -> () ) {
//        NetworkManager.session
//            .request(HomeRouter.getList)
//            .validate(statusCode: 200..<300)
//            .responseJSON(completionHandler: completion)
//    }
    static func getSchedule() -> AnyPublisher<Schedules, AFError> {
        NetworkManager.session
            .request(HomeRouter.getSchedule(userId: SecurityManager.shared.load(account: .userID) ?? ""))
            .validate(statusCode: 200..<300)
            .publishDecodable(type: Schedules.self)
            .value()
            .eraseToAnyPublisher()
    }
    
        
}


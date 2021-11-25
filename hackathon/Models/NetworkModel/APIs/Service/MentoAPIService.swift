//
//  MentoAPIService.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/24.
//

import Foundation
import Alamofire
import CoreLocation

enum MentoAPIService {
    
    static func register(content: String,
                         preferredLocation: String,
                         untact: Bool,
                         userId: String,
                         completion: @escaping (AFDataResponse<Any>) -> () ) {
        NetworkManager.session
            .request(MentoRouter.register(content: content,
                                          preferredLocation: preferredLocation,
                                          untact: untact,
                                          userId: userId))
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: completion)
    }
    
    static func sendEmail(email: String,
                          completion: @escaping (AFDataResponse<Any>) -> () ) {
        NetworkManager.session
            .request(MentoRouter.sendEmail(email: email))
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: completion)
    }
    
    static func authenticate(passcode: String,
                             completion: @escaping (AFDataResponse<Any>) -> () ) {
        NetworkManager.session
            .request(MentoRouter.authenticate(passcode: passcode))
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: completion)
    }
    
}

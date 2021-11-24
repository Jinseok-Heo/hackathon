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
    
    static func register(email: String,
                         content: String,
                         preferredLocation: CLLocationCoordinate2D,
                         untact: Bool,
                         userId: String,
                         completion: @escaping (AFDataResponse<Any>) -> () ) {
        APIClient.shared.session
            .request(MentoRouter.register(email: email,
                                          content: content,
                                          preferredLocation: preferredLocation,
                                          untact: untact,
                                          userId: userId))
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: completion)
    }
    
    static func authenticate(email: String,
                             completion: @escaping (AFDataResponse<Any>) -> () ) {
        
    }
    
}

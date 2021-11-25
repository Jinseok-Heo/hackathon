//
//  BaseInterceptor.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import Foundation
import Alamofire

class BaseInterceptor: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        if let accessToken = SecurityManager.shared.load(account: .accessToken) {
            request.addValue(String("Bearer \(accessToken)"), forHTTPHeaderField: "Authorization")
        }
        completion(.success(request))
    }
    
//    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//        
//    }
    
}

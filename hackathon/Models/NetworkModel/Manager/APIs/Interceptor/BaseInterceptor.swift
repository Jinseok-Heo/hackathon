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
        
        let verifiedToken = UserDefaultsManager.shared.getTokens().verifiedToken
        request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        if verifiedToken != "" {
            request.addValue(String("Bearer \(verifiedToken)"), forHTTPHeaderField: "Authorization")
        }
        completion(.success(request))
    }
    
//    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
//        
//    }
    
}

//
//  APIClient.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import Foundation
import Alamofire

final class APIClient {
    
    static let shared = APIClient()
    
    let interceptors = Interceptor(interceptors: [
        BaseInterceptor()
    ])
    
    let monitors = [APILogger()] as [EventMonitor]
    
    var session: Session
    
    init() {
        session = Session(interceptor: interceptors)
    }
    
    init(interceptor: RequestInterceptor) {
        session = Session(interceptor: interceptor)
    }
    
}

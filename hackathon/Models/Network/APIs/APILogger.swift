//
//  APILogger.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import Foundation
import Alamofire

final class APILogger: EventMonitor {
    
    let queue: DispatchQueue = DispatchQueue(label: "hackathon")
    
    func requestDidFinish(_ request: Request) {
        print("========= NETWORK Reqeust LOG =========")
        print(request.description)
        print(
            "URL: " + (request.request?.url?.absoluteString ?? "")  + "\n"
            + "Method: " + (request.request?.httpMethod ?? "") + "\n"
            + "Headers: " + "\(request.request?.allHTTPHeaderFields ?? [:])" + "\n"
        )
        print("Authorization: " + (request.request?.headers["Authorization"] ?? ""))
        print("Body: " + (request.request?.httpBody?.toPrettyPrintedString ?? ""))
        print("============== End Line ==============\n")
    }
    
}

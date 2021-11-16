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
    
    func requestDidResume(_ request: Request) {
        print("Resuming: \(request)")
    }
    
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        debugPrint("Finished: \(response)")
    }
    
}

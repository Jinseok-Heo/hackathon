//
//  ImageAPIService.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/23.
//

import Foundation
import Alamofire

enum ImageAPIService {
    
    static func upload(image: Data,
                       userId: String,
                       to url: URLConvertible,
                       completion: @escaping (AFDataResponse<Any>) -> () ) {
        
        let header: HTTPHeaders = [
            HTTPHeader(name: "Content-Type", value: "multipart/form-data"),
            HTTPHeader(name: "Authorization", value: UserDefaultsManager.shared.getUserId())
        ]
        
        AF.upload(multipartFormData: { data in
                data.append(userId.data(using: .utf8)!, withName: "userId")
                data.append(image, withName: "image", fileName: "image", mimeType: "image/jpeg")
            }, to: url, method: .post, headers: header)
            .validate(statusCode: 200..<300)
            .uploadProgress(closure: { progress in
                NSLog(progress.description)
            })
            .responseJSON(completionHandler: completion)
    }
    
}

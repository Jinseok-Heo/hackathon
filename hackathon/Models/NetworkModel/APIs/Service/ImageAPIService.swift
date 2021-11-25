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
                       completion: @escaping (AFDataResponse<Any>) -> () ) {
        
        var header = SecurityManager.shared.getAuthorizationHeader()
        header!.add(name: "Content-Type", value: "multipart/form-data")        
        let url = URL(string: NetworkManager.base + "/app/user/profileImg")!
        
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

//
//  ImageAPIService.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/23.
//

import Foundation
import Alamofire

enum ImageAPIService {
    
    static func upload(image: Data, to url: URLConvertible, completion: @escaping (AFDataResponse<Any>) -> () ) {
        let params: [String:Any] = ["Hi" : ["Hello"]]
        APIClient.shared.session
            .upload(multipartFormData: { data in
                for (key, value) in params {
                    if let temp = value as? String {
                        data.append(temp.data(using: .utf8)!, withName: key)
                    }
                    if let temp = value as? Int {
                        data.append("\(temp)".data(using: .utf8)!, withName: key)
                    }
                    if let temp = value as? NSArray {
                        temp.forEach({ element in
                            let keyObj = key + "[]"
                            if let string = element as? String {
                                data.append(string.data(using: .utf8)!, withName: keyObj)
                            } else
                            if let num = element as? Int {
                                let value = "\(num)"
                                data.append(value.data(using: .utf8)!, withName: keyObj)
                            }
                        })
                    }
                }
                data.append(image, withName: "file", fileName: "file.png", mimeType: "image/png")
            }, to: url)
            .validate(statusCode: 200..<300)
            .uploadProgress(closure: { progress in
                NSLog(progress.description)
            })
            .responseJSON(completionHandler: completion)
    }
    
}


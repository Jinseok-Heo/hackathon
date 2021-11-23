//
//  ProfileViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/23.
//

import SwiftUI
import Alamofire

class ProfileViewModel: ObservableObject {
    
    @Published
    var image: UIImage
    @Published
    var isLoading: Bool
    @Published
    var isFailed: Bool
    
    public init() {
        self.image = UIImage(named: "userPlaceholder")!
        self.isLoading = false
        self.isFailed = false
    }
    
    public func imageUpload() {
        let encodedData = self.image.jpegData(compressionQuality: 0.5)!
        ImageAPIService.upload(image: encodedData, to: URL(string: "")!) { response in
            // Log for response
            if let desc = response.response?.description {
                NSLog(desc)
            } else {
                NSLog("Can't get response description")
            }
            // Log for header
            if let headInfo = response.request?.headers {
                NSLog(headInfo.description)
            } else {
                NSLog("Can't get header description")
            }
            
            // Log for result
            switch response.result {
            case .success:
                guard let response = response.response else {
                    NSLog("ViewModels/Auth/ProfileViewModel/imageUpload Error: Can't get response(nil)")
                    return
                }
                NSLog(response.description)
            case .failure(let err):
                NSLog(err.localizedDescription)
            }
        }
    }
    
}

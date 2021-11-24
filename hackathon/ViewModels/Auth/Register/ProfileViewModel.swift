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
    @Published
    var didSuccess: Bool
    @Published
    var showAlert: Bool
    @Published
    var alertMsg: String
    
    public init() {
        self.image = UIImage(named: "userPlaceholder")!
        self.isLoading = false
        self.isFailed = false
        self.didSuccess = false
        self.showAlert = false
        self.alertMsg = ""
    }
    
    public func upload() {
        let encodedData = self.image.jpegData(compressionQuality: 0.3)!
        ImageAPIService.upload(image: encodedData,
                               userId: UserDefaultsManager.shared.getUserId(),
                               to: URL(string: "http://localhost:8888/user/profileImg")!,
                               completion: imageUploadCompletionHandler)
    }
    
    public func uploadDefault() {
        let encodedData = UIImage(named: "userPlaceholder")!.jpegData(compressionQuality: 0.3)!
        ImageAPIService.upload(image: encodedData,
                               userId: UserDefaultsManager.shared.getUserId(),
                               to: URL(string: "http://localhost:8888/user/profileImg")!,
                               completion: imageUploadCompletionHandler)
    }
    
    private func imageUploadCompletionHandler(response: AFDataResponse<Any>) {
        NSLog(response.description)
        if let desc = response.response?.description {
            NSLog(desc)
        } else {
            NSLog("Can't get response description")
        }
        // Log for result
        switch response.result {
        case .success:
            guard let _ = response.response else {
                NSLog("ViewModels/Auth/ProfileViewModel/imageUpload Error: Can't get response(nil)")
                return
            }
            NSLog("User profile image has successfully updated!")
            self.didSuccess = true
        case .failure(let err):
            NSLog(err.localizedDescription)
        }
    }
    
}

extension ProfileViewModel {
    
    private func generateAlert(message: String) {
        alertMsg = message
        showAlert = true
    }
    
}

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
    var image: UIImage?
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
        self.image = nil
        self.isLoading = false
        self.isFailed = false
        self.didSuccess = false
        self.showAlert = false
        self.alertMsg = ""
    }
    
    public func upload() {
        var encodedData = UIImage(systemName: "person.fill")!.jpegData(compressionQuality: 0.3)!
        isLoading = true
        if let image = image {
            encodedData = image.jpegData(compressionQuality: 0.3)!
        }
        ImageAPIService.upload(image: encodedData,
                               userId: SecurityManager.shared.load(account: .userID)!,
                               completion: imageUploadCompletionHandler)
    }
    
    public func uploadDefault() {
        isLoading = true
        let encodedData = UIImage(named: "userPlaceholder")!.jpegData(compressionQuality: 0.3)!
        ImageAPIService.upload(image: encodedData,
                               userId: SecurityManager.shared.load(account: .userID)!,
                               completion: imageUploadCompletionHandler)
    }
    
    private func imageUploadCompletionHandler(response: AFDataResponse<Any>) {
        isLoading = false
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
            self.didSuccess = true
        case .failure(let err):
            NSLog(err.localizedDescription)
            generateAlert(message: "네트워크 연결을 확인해주세요")
        }
    }
    
}

extension ProfileViewModel {
    
    private func generateAlert(message: String) {
        alertMsg = message
        showAlert = true
    }
    
}

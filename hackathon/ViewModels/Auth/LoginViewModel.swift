//
//  LoginViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/20.
//

import Foundation
import Alamofire
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    
    @Published
    var userName: String
    @Published
    var password: String
    @Published
    var showAlert: Bool
    @Published
    var alertMsg: String
    @Published
    var action: Int?
    @Published
    var isLoading: Bool
    
    public init() {
        self.userName = ""
        self.password = ""
        self.showAlert = false
        self.alertMsg = ""
        self.action = 0
        self.isLoading = false
    }
    
    func tryLogin() {
        let encodedPassword = password.toBase64()
        isLoading = true
        AuthAPIService.login(userName: userName, password: encodedPassword, completion: loginCompletionHandler)
    }
    
    private func loginCompletionHandler(response: AFDataResponse<Any>) {
        weak var _self = self
        _self?.isLoading = false
        guard let self = _self else {
            NSLog("ViewModels/Auth/LoginViewModel/tryLogin : self is nil")
            return
        }
        if let err = response.error {
            if response.response?.statusCode == 401 {
                print(err.localizedDescription)
                generateAlert(message: "등록된 사용자가 없습니다.\n이메일 및 비밀번호를 확인해주세요.")
            } else {
                generateAlert(message: "네트워크 연결을 확인해주세요")
            }
            return
        }
        if let headerFields = response.response?.allHeaderFields {
            guard let verifiedToken = headerFields["verify-token"] as? String else {
                NSLog("ViewModels/Auth/LoginViewModel/tryLogin Convert Error: Can't convert verify-token to string")
                self.generateAlert(message: "토큰을 가져올 수 없습니다. 고객센터에 문의하세요")
                return
            }
            guard let refreshToken = headerFields["refresh-token"] as? String else {
                NSLog("ViewModels/Auth/LoginViewModel/tryLogin Convert Error: Can't convert refresh-token to string")
                self.generateAlert(message: "토큰을 가져올 수 없습니다. 고객센터에 문의하세요")
                return
            }
            guard let userId = headerFields["user-id"] as? String else {
                NSLog("ViewModels/Auth/LoginViewModel/tryLogin Convert Error: Can't convert userId to string")
                self.generateAlert(message: "유저 ID를 가져올 수 없습니다. 고객센터에 문의하세요")
                return
            }
            SecurityManager.shared.save(account: .accessToken, value: verifiedToken)
            SecurityManager.shared.save(account: .refreshToken, value: refreshToken)
            SecurityManager.shared.save(account: .userID, value: userId)
            self.action = 2
        } else {
            NSLog("There is no header in data")
        }
    }
    
    private func generateAlert(message: String) {
        self.alertMsg = message
        self.showAlert = true
    }
    
}

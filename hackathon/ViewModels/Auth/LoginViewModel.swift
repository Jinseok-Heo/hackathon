//
//  LoginViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/20.
//

import Foundation

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
    
    public init() {
        self.userName = "ex1234"
        self.password = "hh44061312!"
        self.showAlert = false
        self.alertMsg = ""
        self.action = 0
    }
    
    func tryLogin() {
        let encodedPassword = password.toBase64()
        
        AuthAPIService.login(userName: userName, password: encodedPassword) { [weak self] response in
            NSLog(response.description)
            if response.error != nil {
                NSLog(response.error!.localizedDescription)
                self?.alertMsg = "로그인 실패"
                self?.showAlert = true
                return
            }
            print(response)
            self?.action = 2
        }
    }
    
}

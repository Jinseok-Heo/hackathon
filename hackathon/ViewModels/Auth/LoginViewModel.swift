//
//  LoginViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/20.
//

import Foundation
import Alamofire

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
        let url = "https://a24c-121-141-119-67.ngrok.io/user/login?username=\(userName)&password=\(encodedPassword)"
        print(url)
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (json) in
                //여기서 가져온 데이터를 자유롭게 활용하세요.
                print(json)
            }
        
//        AuthAPIService.login(userName: userName, password: encodedPassword) { [weak self] response in
//            NSLog(response.description)
//            if response.error != nil {
//                NSLog(response.error!.localizedDescription)
//                self?.alertMsg = "로그인 실패"
//                self?.showAlert = true
//                return
//            }
//            print(response.response?.headers)
//            print(response)
//            self?.action = 2
//        }
    }
    
}

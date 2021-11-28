//
//  EmailAuthViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/26.
//

import SwiftUI

class EmailAuthViewModel: ObservableObject {
    
    @Published
    var email: String
    @Published
    var authCode: String
    @Published
    var didAuthSuccess: Bool
    @Published
    var showEmailAuth: Bool
    
    @Published
    var isLoading: Bool
    @Published
    var showAlert: Bool
    @Published
    var alertTitle: String
    @Published
    var alertMsg: String
    
    public init() {
        self.email = ""
        self.authCode = ""
        self.didAuthSuccess = false
        self.showEmailAuth = false
        self.isLoading = false
        self.showAlert = false
        self.alertMsg = ""
        self.alertTitle = ""
    }
    
    public func emailAuthenticate() {
        guard email != "" && checkEmail() else {
            generageAlert(title: "올바르지 않은 이메일", message: "이메일을 올바르게 입력해주세요.")
            return
        }
        isLoading = true
        MentoAPIService.sendEmail(email: email) { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response.result {
            case .success:
                self.showEmailAuth = true
                self.generageAlert(title: "인증코드 발송", message: "메일을 확인해주세요")
            case .failure(let error):
                NSLog(error.localizedDescription)
                self.generageAlert(title: "인증코드 발송 실패", message: "이메일 발송 실패")
            }
        }
    }
    
    public func submitPasscode() {
        isLoading = true
        MentoAPIService.authenticate(passcode: authCode) { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response.result {
            case .success:
                self.showEmailAuth = false
                self.alertTitle = "인증 성공"
                self.alertMsg = "인증이 완료되었습니다."
                self.didAuthSuccess = true
            case .failure(let error):
                if let statusCode = response.response?.statusCode {
                    if statusCode >= 400 && statusCode < 500 {
                        self.generageAlert(title: "인증 실패", message: "인증코드를 확인해주세요")
                    } else {
                        self.generageAlert(title: "인증 실패", message: "네트워크 연결을 확인해주세요")
                    }
                } else {
                    self.generageAlert(title: "인증 실패", message: "네트워크 연결을 확인해주세요")
                }
                NSLog(error.localizedDescription)
            }
        }
    }
    
    private func checkEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func generageAlert(title: String, message: String) {
        alertTitle = title
        alertMsg = message
        showAlert = true
    }
    
}

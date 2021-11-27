//
//  BasicInfoViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/23.
//

import SwiftUI
import Combine

class BasicInfoViewModel: ObservableObject {
    
    @Published
    var cancellabels = Set<AnyCancellable>()
    
    @Published
    var nickName: String
    @Published
    var userName: String
    @Published
    var password: String
    @Published
    var verifiedPassword: String
    @Published
    var gender: Int
    @Published
    var birth: String
    
    @Published
    var submitSuccess: Bool
    @Published
    var showPassword: Bool
    @Published
    var isValidPassword: Bool
    
    @Published
    var showAlert: Bool
    @Published
    var alertMsg: String
    
    public init() {
        self.nickName = ""
        self.userName = ""
        self.password = ""
        self.verifiedPassword = ""
        self.birth = ""
        self.showAlert = false
        self.submitSuccess = false
        self.alertMsg = ""
        self.gender = 0
        self.showPassword = false
        self.isValidPassword = false
        
        addPasswordSubscriber()
    }
    
    public func submitForm() {
        if checkForm() {
            submitSuccess = true
        }
    }
    
}

extension BasicInfoViewModel {
    
    private func addPasswordSubscriber() {
        $password
            .sink { [weak self] pwd in
                self?.isValidPassword = (pwd == self?.verifiedPassword && pwd != "")
            }
            .store(in: &cancellabels)
        $verifiedPassword
            .sink { [weak self] vpwd in
                self?.isValidPassword = (vpwd == self?.password && vpwd != "")
            }
            .store(in: &cancellabels)
    }
    
    private func generateAlert(message: String) {
        alertMsg = message
        showAlert = true
    }
    
    private func checkForm() -> Bool {
        guard nickName != "" else {
            generateAlert(message: "닉네임을 입력해주세요")
            return false
        }
        guard password == verifiedPassword else {
            return false
        }
        guard checkPassword() else {
            generateAlert(message: "문자, 숫자, 특수문자를 사용한 8~16자리 비밀번호를 입력해주세요")
            return false
        }
        guard password != "" else {
            generateAlert(message: "비밀번호를 입력해주세요")
            return false
        }
        guard userName != "" else {
            generateAlert(message: "아이디를 입력해주세요")
            return false
        }
        guard gender != 0 else {
            generateAlert(message: "성별을 선택해주세요")
            return false
        }
        guard birth != "" , checkBirth() else {
            generateAlert(message: "생년월일을 올바르게 입력해주세요")
            return false
        }
        return true
    }
    
    private func checkPassword() -> Bool {
        let regex = "^(?=.*[A-Za-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,16}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: password)
    }
    
    private func checkBirth() -> Bool {
        if birth.count != 6 {
            return false
        }
        let year = Int(birth.substring(from: 0, to: 1))
        let month = Int(birth.substring(from: 2, to: 3))
        let day = Int(birth.substring(from: 4, to: 5))
        let components = DateComponents(year: year, month: month, day: day)
        let date = Calendar.current.date(from: components)
        if date == nil {
            return false
        }
        return true
    }
    
}

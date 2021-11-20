//
//  RegisterViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/20.
//

import SwiftUI
import Alamofire

class RegisterViewModel: ObservableObject {
    
    @Published
    var email: String
    @Published
    var password: String
    @Published
    var verifiedPassword: String
    @Published
    var userName: String
    @Published
    var nickName: String
    @Published
    var gender: Int
    @Published
    var birth: String
    @Published
    var company: String
    @Published
    var job: String
    @Published
    var year: String
    @Published
    var school: String
    @Published
    var major: String
    
    @Published
    var showPassword: Bool
    @Published
    var showAlert: Bool
    @Published
    var alertMsg: String
    @Published
    var pageState: Int
    @Published
    var registerCompleted: Bool
    
    public init() {
        self.email = "ex1234@gmail.com"
        self.password = "hh44061312!"
        self.verifiedPassword = "hh44061312!"
        self.userName = "ex1234"
        self.nickName = "exName"
        self.gender = 0
        self.birth = "971110"
        self.company = ""
        self.year = ""
        self.job = ""
        self.school = "경희대학교"
        self.major = "기계공학과"
        
        self.showPassword = false
        self.showAlert = false
        self.alertMsg = ""
        self.pageState = 0
        self.registerCompleted = false
    }
    
    func tryRegister() {
        
        var genderEng: String = ""
        var yearInt: Int? = nil
        
        if password != verifiedPassword {
            alertMsg = "올바른 비밀번호를 입력해주세요"
            showAlert = true
            return
        }
        guard email != "" else {
            alertMsg = "이메일을 입력해주세요"
            showAlert = true
            return
        }
        guard verifiedPassword != "" else {
            alertMsg = "비밀번호를 입력해주세요"
            showAlert = true
            return
        }
        guard userName != "" else {
            alertMsg = "아이디를 입력해주세요"
            showAlert = true
            return
        }
        guard nickName != "" else {
            alertMsg = "이름을 입력해주세요"
            showAlert = true
            return
        }
        guard birth != "" else {
            alertMsg = "생년월일을 입력해주세요"
            showAlert = true
            return
        }
        guard gender == 0 else {
            alertMsg = "성별을 선택해주세요"
            showAlert = true
            return
        }
        guard school != "" else {
            alertMsg = "학교를 입력해주세요"
            showAlert = true
            return
        }
        guard major != "" else {
            alertMsg = "전공을 입력해주세요"
            showAlert = true
            return
        }
        
        if year != "" {
            yearInt = Int(year)
        }
        if gender == 0 {
            genderEng = "male"
        } else {
            genderEng = "female"
        }
        let encodedPassword = password.toBase64()
        
        AuthAPIService.register(email: email, password: encodedPassword, userName: userName, nickName: nickName, gender: genderEng, birth: birth, company: company == "" ? nil : company, job: job == "" ? nil : job, year: yearInt, school: school, major: major, completion: registerCompletionHandler)
    }
    
    private func registerCompletionHandler(response: AFDataResponse<Any>) {
        if response.error != nil {
            generateAlert(message: "회원가입 실패")
            return
        }
        let encodedPassword = self.password.toBase64()
        AuthAPIService.login(userName: userName, password: encodedPassword, completion: loginCompletionHandler)
    }
    
    private func loginCompletionHandler(response: AFDataResponse<Any>) {
        if response.error != nil {
            generateAlert(message: "로그인 실패")
            return
        }
        self.registerCompleted = true
    }
    
    public func buttonHandler() {
        if pageState == 0 {
            if gender != 0 {
                pageState += 1
            } else {
                generateAlert(message: "성별을 선택해주세요")
                return
            }
        } else if pageState == 1 {
            if school != "" && major != "" {
                tryRegister()
            } else {
                generateAlert(message: "정보를 올바르게 입력해주세요")
            }
        }
    }
    
    private func generateAlert(message: String) {
        alertMsg = message
        showAlert = true
    }
    
}



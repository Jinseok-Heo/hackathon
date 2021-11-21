//
//  RegisterViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/20.
//

import SwiftUI
import Alamofire
import Combine

class RegisterViewModel: ObservableObject {
    
    @Published
    var cancellabels = Set<AnyCancellable>()
    
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
    var schoolList: [String]
    @Published
    var majorList: [String]
    @Published
    var isSchoolListPresented: Bool
    @Published
    var isMajorListPresented: Bool
    
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
    @Published
    var isLoading: Bool
    
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
        self.school = ""
        self.major = ""
        
        self.schoolList = []
        self.majorList = []
        self.isSchoolListPresented = true
        self.isMajorListPresented = true
        
        self.showPassword = false
        self.showAlert = false
        self.alertMsg = ""
        self.pageState = 0
        self.registerCompleted = false
        self.isLoading = false
        
        addSchoolSubscriber()
        addMajorSubscriber()
    }
    
    func tryRegister() {
        
        var genderEng: String = ""
        var yearInt: Int? = nil
        
        if password != verifiedPassword {
            generateAlert(message: "올바른 비밀번호를 입력해주세요")
            return
        }
        guard email != "" else {
            generateAlert(message: "이메일을 입력해주세요")
            return
        }
        guard verifiedPassword != "" else {
            generateAlert(message: "비밀번호를 입력해주세요")
            return
        }
        guard userName != "" else {
            generateAlert(message: "아이디를 입력해주세요")
            return
        }
        guard nickName != "" else {
            generateAlert(message: "이름을 입력해주세요")
            return
        }
        guard birth != "" else {
            generateAlert(message: "생년월일을 입력해주세요")
            return
        }
        guard gender != 0 else {
            generateAlert(message: "성별을 선택해주세요")
            return
        }
        guard school != "" else {
            generateAlert(message: "학교를 입력해주세요")
            return
        }
        guard major != "" else {
            generateAlert(message: "전공을 입력해주세요")
            return
        }
        
        if year != "" {
            yearInt = Int(year)
        }
        if gender == 1 {
            genderEng = "male"
        } else {
            genderEng = "female"
        }
        let encodedPassword = password.toBase64()
        
        AuthAPIService.register(email: email, password: encodedPassword, userName: userName, nickName: nickName, gender: genderEng, birth: birth, company: company == "" ? nil : company, job: job == "" ? nil : job, year: yearInt, school: school, major: major, completion: registerCompletionHandler)
    }
    
    private func addSchoolSubscriber() {
        $school
            .sink { [weak self] query in
                guard let self = self else { return }
                self.schoolList = DummyData.schoolList.filter { $0.decomposeHangul().contains(query.decomposeHangul()) }
            }
            .store(in: &cancellabels)
    }
    
    private func addMajorSubscriber() {
        $major
            .sink { [weak self] query in
                guard let self = self else { return }
                self.majorList = DummyData.majorList.filter { $0.decomposeHangul().contains(query.decomposeHangul()) }
            }
            .store(in: &cancellabels)
    }
    
    private func registerCompletionHandler(response: AFDataResponse<Any>) {
        if response.error != nil {
            NSLog(response.error!.localizedDescription)
            generateAlert(message: "네트워크 연결을 확인해주세요")
            return
        }
        let encodedPassword = self.password.toBase64()
        AuthAPIService.login(userName: userName, password: encodedPassword, completion: loginCompletionHandler)
    }
    
    private func loginCompletionHandler(response: AFDataResponse<Any>) {
        weak var _self = self
        NSLog(response.description)
        _self?.isLoading = false
        guard let self = _self else {
            NSLog("ViewModels/Auth/LoginViewModel/tryLogin : self is nil")
            return
        }
        if response.error != nil {
            NSLog(response.error!.localizedDescription)
            self.generateAlert(message: "네트워크 연결을 확인해주세요")
            return
        }
        if let headerFields = response.response?.allHeaderFields {
            guard let verifiedToken = headerFields["verified-token"] as? String else {
                NSLog("ViewModels/Auth/LoginViewModel/tryLogin Convert Error: Can't convert verified-token to string")
                self.generateAlert(message: "토큰을 가져올 수 없습니다. 고객센터에 문의하세요")
                return
            }
            guard let refreshToken = headerFields["refresh-token"] as? String else {
                NSLog("ViewModels/Auth/LoginViewModel/tryLogin Convert Error: Can't convert refresh-token to string")
                self.generateAlert(message: "토큰을 가져올 수 없습니다. 고객센터에 문의하세요")
                return
            }
            UserDefaultsManager.shared.setTokens(verifiedToken: verifiedToken,
                                                 refreshToken: refreshToken)
            self.registerCompleted = true
        } else {
            NSLog("There is no header in data")
        }
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
    
    public func isSchoolValidate() -> Bool {
        return schoolList.contains(school)
    }
    
    public func generateAlert(message: String) {
        alertMsg = message
        showAlert = true
    }
    
}



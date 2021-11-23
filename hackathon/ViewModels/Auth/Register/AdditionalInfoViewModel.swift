//
//  AdditionalInfoViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/23.
//

import SwiftUI
import Combine
import Alamofire

class AdditionalInfoViewModel: ObservableObject {
    
    @Published
    var cancellabels = Set<AnyCancellable>()
    
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
    var showAlert: Bool
    @Published
    var alertMsg: String
    @Published
    var registerCompleted: Bool
    @Published
    var isLoading: Bool
    
    let userName: String
    let nickName: String
    let password: String
    let gender: Int
    let birth: String
    
    public init(userName: String, nickName: String, password: String, gender: Int, birth: String) {
        self.userName = userName
        self.nickName = nickName
        self.password = password
        self.gender = gender
        self.birth = birth
        
        self.school = ""
        self.major = ""
        self.schoolList = []
        self.majorList = []
        self.isSchoolListPresented = false
        self.isMajorListPresented = false
        self.showAlert = false
        self.alertMsg = ""
        self.registerCompleted = false
        self.isLoading = false
        
        addSchoolSubscriber()
        addMajorSubscriber()
    }
    
    public func register() {
        var genderEng: String = ""
//        var yearInt: Int? = 0
        
        guard school != "" else {
            generateAlert(message: "학교를 입력해주세요")
            return
        }
        guard major != "" else {
            generateAlert(message: "전공을 입력해주세요")
            return
        }
        
//        if year != "" {
//            yearInt = Int(year)
//        }
        if gender == 1 {
            genderEng = "male"
        } else {
            genderEng = "female"
        }
        let encodedPassword = password.toBase64()
        isLoading = true
        AuthAPIService.register(email: userName, password: encodedPassword, userName: userName, nickName: nickName, gender: genderEng, birth: birth, company: nil, job: nil, year: 0, school: school, major: major, completion: registerCompletionHandler)
    }
    
    public func isSchoolValidate() -> Bool {
        return schoolList.contains(school)
    }
    
}

extension AdditionalInfoViewModel {
    
    public func generateAlert(message: String) {
        alertMsg = message
        showAlert = true
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
    
    private func registerCompletionHandler(response: AFDataResponse<Any>) {
        if response.error != nil {
            NSLog(response.error!.localizedDescription)
            generateAlert(message: "네트워크 연결을 확인해주세요")
            isLoading = false
            return
        }
        let encodedPassword = self.password.toBase64()
        AuthAPIService.login(userName: userName, password: encodedPassword, completion: loginCompletionHandler)
    }
    
}
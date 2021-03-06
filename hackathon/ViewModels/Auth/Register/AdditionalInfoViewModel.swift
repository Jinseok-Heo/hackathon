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
    var company: String
    @Published
    var year: String
    @Published
    var job: String
    
    @Published
    var schoolList: [String]
    @Published
    var majorList: [String]
    @Published
    var isSchoolListPresented: Bool
    @Published
    var isMajorListPresented: Bool
    @Published
    var isStudent: Bool
    
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
    
    var yearInt: Int? {
        if year == "" {
            return nil
        }
        return Int(year)
    }
    
    var genderStr: String {
        switch gender {
        case 1:
            return "male"
        case 2:
            return "female"
        default:
            return ""
        }
    }
    
    public init(userName: String, nickName: String, password: String, gender: Int, birth: String) {
        self.userName = userName
        self.nickName = nickName
        self.password = password
        self.gender = gender
        self.birth = birth
        self.isStudent = true
        
        self.school = ""
        self.major = ""
        self.company = ""
        self.year = ""
        self.job = ""
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
        if !checkForm() {
            return
        }
        let encodedPassword = password.toBase64()
        isLoading = true
        AuthAPIService.register(email: userName,
                                password: encodedPassword,
                                userName: userName,
                                nickName: nickName,
                                gender: genderStr,
                                birth: birth,
                                company: company == "" ? nil : company,
                                job: job == "" ? nil : job,
                                year: yearInt ?? 0,
                                school: school,
                                major: major,
                                completion: registerCompletionHandler)
    }
    
    public func isSchoolValidate() -> Bool {
        return DataSet.schoolList.contains(school) && school != ""
    }
    
    public func isMajorValidate() -> Bool {
        return DataSet.majorList.contains(major) && school != ""
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
                self.schoolList = DataSet.schoolList.filter { $0.decomposeHangul().contains(query.decomposeHangul()) }
            }
            .store(in: &cancellabels)
    }
    
    private func addMajorSubscriber() {
        $major
            .sink { [weak self] query in
                guard let self = self else { return }
                self.majorList = DataSet.majorList.filter { $0.decomposeHangul().contains(query.decomposeHangul()) }
            }
            .store(in: &cancellabels)
    }
    
    private func checkForm() -> Bool {
        guard school != "" else {
            generateAlert(message: "????????? ??????????????????")
            return false
        }
        guard major != "" else {
            generateAlert(message: "????????? ??????????????????")
            return false
        }
        guard checkOptionalField() else {
            generateAlert(message: "??????????????? ???????????? ??????????????????")
            return false
        }
        return true
    }
    
    // Check form of company, job, year
    private func checkOptionalField() -> Bool {
        if company != "" && yearInt != nil && job != "" {
            return true
        }
        if company == "" && yearInt == nil && job == "" {
            return true
        }
        return false
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
            self.generateAlert(message: "???????????? ????????? ??????????????????")
            return
        }
        if let headerFields = response.response?.allHeaderFields {
            print(headerFields)
            guard let accessToken = headerFields["verify-token"] as? String else {
                NSLog("ViewModels/Auth/LoginViewModel/tryLogin Convert Error: Can't convert accessToken to string")
                self.generateAlert(message: "????????? ????????? ??? ????????????. ??????????????? ???????????????")
                return
            }
            guard let refreshToken = headerFields["refresh-token"] as? String else {
                NSLog("ViewModels/Auth/LoginViewModel/tryLogin Convert Error: Can't convert refreshToken to string")
                self.generateAlert(message: "????????? ????????? ??? ????????????. ??????????????? ???????????????")
                return
            }
            guard let userId = headerFields["user-id"] as? String else {
                NSLog("ViewModels/Auth/LoginViewModel/tryLogin Convert Error: Can't convert userId to string")
                self.generateAlert(message: "?????? ID??? ????????? ??? ????????????. ??????????????? ???????????????")
                return
            }
            SecurityManager.shared.save(account: .accessToken, value: accessToken)
            SecurityManager.shared.save(account: .refreshToken, value: refreshToken)
            SecurityManager.shared.save(account: .userID, value: userId)
            self.registerCompleted = true
        } else {
            NSLog("There is no header in data")
        }
    }
    
    private func registerCompletionHandler(response: AFDataResponse<Any>) {
        switch response.result {
        case .success:
            let encodedPassword = self.password.toBase64()
            AuthAPIService.login(userName: userName, password: encodedPassword, completion: loginCompletionHandler)
        case .failure(let error):
            generateAlert(message: "???????????? ????????? ??????????????????")
            isLoading = false
            NSLog(error.localizedDescription)
        }
    }
    
}

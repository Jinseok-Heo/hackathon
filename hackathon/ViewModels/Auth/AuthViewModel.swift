//
//  AuthViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    
    @Published
    var user: UserResponse? = nil
    
    var cancellables = Set<AnyCancellable>()
    
    func tryLogin(userName: String, password: String) {
        let encodedPassword = password.toBase64()
        AuthAPIService.login(userName: userName, password: encodedPassword)
            .sink { err in
                print(err)
            } receiveValue: { [weak self] user in
                self?.user = user
                if let user = self?.user {
                    print(user)
                }
            }
            .store(in: &cancellables)
    }
    
    func tryRegister(email: String,
                     password: String,
                     userName: String,
                     nickName: String,
                     gender: String,
                     birth: String,
                     company: String,
                     job: String,
                     year: Int,
                     school: String,
                     major: String) {
        let encodedPassword = password.toBase64()
        AuthAPIService.register(email: email, password: encodedPassword, userName: userName, nickName: nickName, gender: gender, birth: birth, company: company, job: job, year: year, school: school, major: major)
            .sink { err in
                print(err)
            } receiveValue: { [weak self] user in
                self?.user = user
                if let user = self?.user {
                    print(user)
                }
            }
            .store(in: &cancellables)
    }
    
}

extension String {
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

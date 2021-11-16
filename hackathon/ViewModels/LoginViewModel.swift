//
//  LoginViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    
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
    
}

extension String {
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

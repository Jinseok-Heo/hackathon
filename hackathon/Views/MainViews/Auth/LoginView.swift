//
//  LoginView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import SwiftUI

struct SuccessView: View {
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            Text("Login Success!")
        }
    }
    
}

struct LoginView: View {
    
    @StateObject
    var loginVM: AuthViewModel = AuthViewModel()
    
    @State
    var userName: String = "ex1234"
    @State
    var password: String = "hh44061312!"
    @State
    var alertPresented: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                TextField("이메일을 입력하세요.", text: $userName)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray)
                SecureField("비밀번호를 입력하세요.", text: $password)
                    .padding()
                    .background(Color.gray)
            }
            .padding()
            HStack {
                Button {
                    loginVM.tryLogin(userName: userName, password: password)
                    if loginVM.user == nil {
                        alertPresented = true
                    }
                } label: {
                    Text("로그인")
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(Color("secondColor"))
                        )
                }
                .alert(isPresented: $alertPresented) {
                    Alert(title: Text("Login failed"))
                }
            }
        }
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}


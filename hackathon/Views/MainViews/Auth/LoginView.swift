//
//  LoginView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject
    var loginVM: LoginViewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    NavigationLink(destination: BasicInfoView(), tag: 1, selection: $loginVM.action) { EmptyView() }
                    NavigationLink(destination: MyTabView(), tag: 2, selection: $loginVM.action) { EmptyView() }
                    titleView
                        .padding(.top, 128)
                    content
                        .padding(.top, 46)
                    loginButton
                        .padding(.top, 32)
                    findInfoButton
                        .padding(.top, 29)
                    Rectangle()
                        .frame(height: 1)
                        .padding(.top, 33)
                    snsLoginContent
                        .padding(.top, 13)
                    Spacer()
                }
                .padding([.leading, .trailing], 22)
            }
            .opacity(loginVM.isLoading ? 0.3 : 1)
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.top)
            if loginVM.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(.circular)
            }
        }
        .alert(isPresented: $loginVM.showAlert) {
            Alert(title: Text("로그인 실패"), message: Text(loginVM.alertMsg), dismissButton: .default(Text("확인")))
        }
    }
    
}

extension LoginView {
    
    private var titleView: some View {
        HStack(alignment: .bottom) {
            Text("로그인")
                .font(FontManager.font(size: 26, weight: .bold))
                .foregroundColor(Color(hex: "#000000"))
            Spacer()
            Button {
                loginVM.action = 1
            } label: {
                Text("회원가입")
                    .font(FontManager.font(size: 14, weight: .bold))
                    .foregroundColor(Color(hex: "#555555"))
            }
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 34) {
            TextFieldView(text: $loginVM.userName, title: "아이디", placeholder: "아이디를 입력해 주세요", type: .text)
            TextFieldView(text: $loginVM.password, title: "비밀번호", placeholder: "비밀번호를 입력해 주세요", type: .secure)
        }
    }
    
    private var loginButton: some View {
        Button {
            loginVM.tryLogin()
        } label: {
            Text("로그인")
                .font(FontManager.font(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding([.top, .bottom], 13)
                .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color("secondColor")))
        }
        
    }
    
    private var findInfoButton: some View {
        HStack {
            Spacer()
            Button {
                
            } label: {
                Text("아이디 / 비밀번호 찾기")
                    .font(FontManager.font(size: 14, weight: .regular))
                    .foregroundColor(Color(hex: "#191919"))
            }
            Spacer()
        }
    }
    
    private var snsLoginContent: some View {
        VStack(spacing: 20) {
            HStack {
                Text("SNS 간편 로그인")
                    .font(FontManager.font(size: 15, weight: .extrabold))
                    .foregroundColor(Color(hex: "191919"))
                Spacer()
            }
            HStack(spacing: 25) {
                ForEach(0..<3) { _ in
                    Circle()
                        .foregroundColor(Color(hex: "#E5E5E5"))
                        .frame(width: 56, height: 56)
                }
            }
        }
    }
    
}

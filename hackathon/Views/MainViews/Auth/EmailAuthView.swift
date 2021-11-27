//
//  EmailAuthView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/25.
//

import SwiftUI

struct EmailAuthView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @StateObject
    var emailAuthVM: EmailAuthViewModel = EmailAuthViewModel()
    
    @ObservedObject
    var homeVM: HomeViewModel
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                headerView
                titleView
                    .padding(.top, 50)
                    .padding(.bottom, 26)
                Spacer()
                VStack(alignment: .leading, spacing: 20) {
                    emailField
                    emailAuthField
                    Spacer()
                }
            }
            if emailAuthVM.isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(.circular)
            }
        }
        .navigationBarHidden(true)
        .padding([.leading, .trailing], 22)
        .alert(isPresented: $emailAuthVM.showAlert) {
            Alert(title: Text(emailAuthVM.alertTitle),
                  message: Text(emailAuthVM.alertMsg),
                  dismissButton: .default(Text("확인")))
        }
        .alert(isPresented: $emailAuthVM.didAuthSuccess) {
            Alert(title: Text(emailAuthVM.alertTitle),
                  message: Text(emailAuthVM.alertMsg),
                  dismissButton: .default(Text("확인")) {
                self.homeVM.getUserProfile()
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
}

extension EmailAuthView {
    
    private var headerView: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .frame(width: 10, height: 17)
                Text("돌아가기")
                    .font(FontManager.font(size: 15, weight: .medium))
                    .offset(y: 2)
            }
            .foregroundColor(Color(hex: "#191919"))
        }
    }
    
    private var titleView: some View {
        Text("이메일 인증하기")
            .font(FontManager.font(size: 26, weight: .bold))
            .foregroundColor(Color(hex: "#191919"))
    }
    
    private var emailField: some View {
        HStack(spacing: 6) {
            TextFieldView(text: $emailAuthVM.email, title: "이메일", placeholder: "인증할 이메일을 입력해주세요", type: .text)
            Button {
                emailAuthVM.emailAuthenticate()
            } label: {
                Text("인증하기")
                    .font(FontManager.font(size: 17, weight: .bold))
                    .foregroundColor(.white)
                    .padding([.leading, .trailing], 8)
                    .padding([.top, .bottom], 8)
                    .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("secondColor")))
            }
        }
    }
    
    @ViewBuilder private var emailAuthField: some View {
        if emailAuthVM.showEmailAuth {
            HStack {
                TextField("인증코드를 입력해주세요", text: $emailAuthVM.authCode)
                    .keyboardType(.numberPad)
                    .font(FontManager.font(size: 15, weight: .medium))
                    .foregroundColor(Color(hex: "#191919"))
                    .padding(14)
                    .background(RoundedRectangle(cornerRadius: 4).foregroundColor(Color(hex: "#CECECE").opacity(0.3)))
                Button {
                    emailAuthVM.submitPasscode()
                } label: {
                    Text("확인")
                        .font(FontManager.font(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .padding([.leading, .trailing], 8)
                        .padding([.top, .bottom], 4)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color("secondColor")))
                }
            }
        }
    }
    
}

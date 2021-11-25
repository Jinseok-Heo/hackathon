//
//  EmailAuthView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/25.
//

import SwiftUI

class EmailAuthViewModel: ObservableObject {
    
    @Published
    var email: String
    @Published
    var authCode: String
    @Published
    var didAuthSuccess: Bool
    @Published
    var showEmailAuth: Bool
    
    @Published
    var isLoading: Bool
    @Published
    var showAlert: Bool
    @Published
    var alertTitle: String
    @Published
    var alertMsg: String
    
    public init() {
        self.email = ""
        self.authCode = ""
        self.didAuthSuccess = false
        self.showEmailAuth = false
        self.isLoading = false
        self.showAlert = false
        self.alertMsg = ""
        self.alertTitle = ""
    }
    
    public func emailAuthenticate() {
        guard email != "" && checkEmail() else {
            generageAlert(message: "이메일을 올바르게 입력해주세요.")
            return
        }
        isLoading = true
        MentoAPIService.sendEmail(email: email) { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response.result {
            case .success:
                self.showEmailAuth = true
                self.generageAlert(message: "인증코드가 발송되었습니다.")
            case .failure(let error):
                NSLog(error.localizedDescription)
                self.generageAlert(message: "이메일 발송 실패")
            }
        }
    }
    
    public func submitPasscode() {
        isLoading = true
        MentoAPIService.authenticate(passcode: authCode) { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response.result {
            case .success:
                self.showEmailAuth = false
                self.didAuthSuccess = true
            case .failure(let error):
                if let statusCode = response.response?.statusCode {
                    if statusCode >= 400 && statusCode < 500 {
                        self.generageAlert(message: "인증코드를 확인해주세요")
                    } else {
                        self.generageAlert(message: "네트워크 연결을 확인해주세요")
                    }
                } else {
                    self.generageAlert(message: "네트워크 연결을 확인해주세요")
                }
                NSLog(error.localizedDescription)
            }
        }
    }
    
    private func checkEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func generageAlert(message: String) {
        if didAuthSuccess {
            alertTitle = "이메일 발송"
        } else {
            alertTitle = "이메일 발송 오류"
        }
        alertMsg = message
        showAlert = true
    }
    
}

struct EmailAuthView: View {
    
    @StateObject
    var emailAuthVM: EmailAuthViewModel = EmailAuthViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            titleView
                .padding(.top, 50)
                .padding(.bottom, 26)
            VStack(alignment: .leading, spacing: 20) {
                emailField
                emailAuthField
                if emailAuthVM.didAuthSuccess {
                    authHelperText
                }
                Spacer()
            }
        }
    }
    
}

extension EmailAuthView {
    
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
                    .padding(8)
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
    
    private var authHelperText: some View {
        Text("이메일 인증 완료 ✅")
            .font(FontManager.font(size: 13, weight: .semibold))
            .foregroundColor(Color(hex: "#191919"))
    }
    
}

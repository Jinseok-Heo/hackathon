//
//  MyPageView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI
import Alamofire

class MyPageViewModel: ObservableObject {
    
    @Published
    var didLogout: Bool
    @Published
    var isVerified: Bool
    
    @Published
    var isLoading: Bool
    @Published
    var alertTitle: String
    @Published
    var alertMsg: String
    @Published
    var showAlert: Bool
    
    @Published
    var selectedItem: Int
    
    public init() {
        self.isLoading = false
        self.alertTitle = ""
        self.alertMsg = ""
        self.showAlert = false
        self.selectedItem = 0
        self.isVerified = UserModel.getUser()?.verified ?? false
        self.didLogout = false
    }
    
}


struct MyPageView: View {
    
    @StateObject
    var myPageVM: MyPageViewModel = MyPageViewModel()
    
    @EnvironmentObject
    var homeVM: HomeViewModel
    
    @State
    var mentoAuth: Bool = false
    @State
    var emailAuth: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                NavigationLink(destination: LoginView(), isActive: $myPageVM.didLogout) { EmptyView() }
                NavigationLink(destination: MentoAuthView(), isActive: $mentoAuth) { EmptyView() }
                NavigationLink(destination: EmailAuthView(homeVM: homeVM), isActive: $emailAuth) { EmptyView() }
                
                logoutButton
                mentoRegisterButton
                refreshTokenButton
            }
            .padding([.leading, .trailing], 22)
        }
        
    }
}

extension MyPageView {
    
    private var logoutButton: some View {
        Button {
            AuthAPIService.logout { response in
                SecurityManager.shared.deleteAll()
                switch response.result {
                case .success:
                    self.myPageVM.didLogout = true
                case .failure(let error):
                    NSLog(error.localizedDescription)
                }
            }
        } label: {
            Text("로그아웃")
                .font(FontManager.font(size: 30, weight: .extrabold))
                .foregroundColor(.white)
                .padding([.top, .bottom], 10)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color("secondColor")))
        }
    }
    
    @ViewBuilder private var mentoRegisterButton: some View {
        if myPageVM.isVerified {
            Button {
                emailAuth = true
            } label: {
                Text("이메일 재인증하기")
                    .font(FontManager.font(size: 30, weight: .extrabold))
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 10)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color("secondColor")))
            }
            Button {
                mentoAuth = true
            } label: {
                Text("멘토 등록")
                    .font(FontManager.font(size: 30, weight: .extrabold))
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 10)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color("secondColor")))
            }
        } else {
            Button {
                emailAuth = true
            } label: {
                Text("이메일 인증")
                    .font(FontManager.font(size: 30, weight: .extrabold))
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 10)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color("secondColor")))
            }
            Button {
                mentoAuth = true
            } label: {
                Text("멘토 등록")
                    .font(FontManager.font(size: 30, weight: .extrabold))
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 10)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color("secondColor")))
            }
        }
    }
    
    private var refreshTokenButton: some View {
        Button {
            NetworkManager.session
                .request(AuthRouter.refreshToken)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    print(response)
                }
        } label: {
            Text("토큰 재발급")
                .font(FontManager.font(size: 30, weight: .extrabold))
                .foregroundColor(.white)
                .padding([.top, .bottom], 10)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color("secondColor")))
        }
    }
}

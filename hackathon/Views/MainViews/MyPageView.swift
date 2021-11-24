//
//  MyPageView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

struct MyPageView: View {
    
    @State
    var didLogout: Bool = false
    
    var body: some View {
        VStack {
            NavigationLink(destination: LoginView(), isActive: $didLogout) { EmptyView() }
            Button {
                AuthAPIService.logout { response in
                    UserDefaultsManager.shared.clearAll()
                    didLogout = true
    //                switch response.result {
    //                case .success:
    //                    presentationMode.wrappedValue.dismiss()
    //                case .failure(let error):
    //                    NSLog(error.localizedDescription)
    //                }
                }
            } label: {
                Text("로그아웃")
                    .font(FontManager.font(size: 30, weight: .extrabold))
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 10)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color("secondColor")))
            }
            Button {
                
            } label: {
                Text("멘토 등록")
                    .font(FontManager.font(size: 30, weight: .extrabold))
                    .foregroundColor(.white)
                    .padding([.top, .bottom], 10)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 5).foregroundColor(Color("secondColor")))
            }
        }
        .padding([.leading, .trailing], 22)
        
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}

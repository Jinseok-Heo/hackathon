//
//  hackathonApp.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

@main
struct hackathonApp: App {
    
    let verifiedToken: String? = SecurityManager.shared.load(account: .accessToken)
    
    var body: some Scene {
        WindowGroup {
//            NavigationView {
//                MyTabView()
//            }
//            NavigationView {
//                MentoAuthView()
//            }
//            TestView()
            NavigationView {
                if verifiedToken == nil {
                    LoginView()
                } else {
                    MyTabView()
                }
            }
//            NavigationView {
//                ReviewPostingView()
//            }
//            NavigationView {
//                RoomView(mento: Mento(id: "3", menteeId: "2", nickName: "멘토1234", profileImage: UIImage(named: "userPlaceholder")!.jpegData(compressionQuality: 0.5)!.base64EncodedString(), content: "여기는 콘텐츠", preferredLocation: "서울/강남", untact: "true"))
//            }
//            NavigationView {
//                MentinkerView()
//            }
        }
    }
    
}

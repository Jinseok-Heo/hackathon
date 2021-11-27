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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
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
//                ProfileView()
//            }
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

class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 1.0) // 런치스크린 표시 시간 1초 강제 지연
        return true
    }
    
}

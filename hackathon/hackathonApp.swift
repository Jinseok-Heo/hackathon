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
//                MentinkerView()
//            }
        }
    }
    
}

//
//  hackathonApp.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

@main
struct hackathonApp: App {
    
    let verifiedToken: String = UserDefaultsManager.shared.getTokens().verifiedToken
    
    var body: some Scene {
        WindowGroup {
//            NavigationView {
//                MyTabView()
//            }
//            NavigationView {
//                MentoAuthView()
//            }
            NavigationView {
                if verifiedToken == "" {
                    LoginView()
                } else {
                    MyTabView()
                }
            }
//            ProfileView()
//            NavigationView {
//                if verifiedToken != "" {
//                    MyTabView()
//                } else {
//                    LoginView()
//                }
//            }
        }
    }
    
}

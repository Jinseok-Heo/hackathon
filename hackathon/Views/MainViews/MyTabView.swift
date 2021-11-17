//
//  MyTabView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

struct MyTabView: View {
    @State
    var selection: TabBarItem = .home
    
    var body: some View {
        CustomTabContainerView(selection: $selection) {
            HomeView()
                .tabBarItem(tab: .home, selection: $selection)
            SearchView()
                .tabBarItem(tab: .mentinker, selection: $selection)
            CommunityView()
                .tabBarItem(tab: .community, selection: $selection)
            ChatView()
                .tabBarItem(tab: .chat, selection: $selection)
            MyPageView()
                .tabBarItem(tab: .myPage, selection: $selection)
        }
//        CustomTabBarView(selectedTab: $selection) {
//           HomeView()
//                .tabBaritem {
//                    Image(selection == 0 ? "home-fill" : "home")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 22)
//                    Text("홈")
//                }
//                .tag(0)
//            SearchView()
//                 .tabItem {
//                     Image(selection == 1 ? "mentinker-fill" : "mentinker")
//                     Text("멘팅커")
//                 }
//                 .tag(1)
//            CommunityView()
//                 .tabItem {
//                     Image(selection == 2 ? "community-fill" : "community")
//                     Text("커뮤니티")
//                 }
//                 .tag(2)
//            ChatView()
//                 .tabItem {
//                     Image(selection == 3 ? "chat-fill" : "chat")
//                     Text("톡")
//                 }
//                 .tag(3)
//            MyPageView()
//                .tabItem {
//                    Image(selection == 4 ? "user-fill" : "user")
//                    Text("마이페이지")
//                }
//                .tag(4)
//        }
    }
}

struct MyTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView()
    }
}


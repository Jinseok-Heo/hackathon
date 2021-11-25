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
            MentinkerView()
                .tabBarItem(tab: .mentinker, selection: $selection)
            CommunityView()
                .tabBarItem(tab: .community, selection: $selection)
            ChatView()
                .tabBarItem(tab: .chat, selection: $selection)
            MyPageView()
                .tabBarItem(tab: .myPage, selection: $selection)
        }
    }
}

struct MyTabView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView()
    }
}


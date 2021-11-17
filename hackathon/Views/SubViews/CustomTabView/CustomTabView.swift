//
//  CustomTabView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/17.
//

import SwiftUI

struct CustomTabBarView: View {

    let tabs: [TabBarItem]
    
    @Binding
    var selectedTab: TabBarItem
    
    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(tabs, id: \.self) { tab in
                tabView(item: tab)
                    .onTapGesture {
                        self.switchTabItem(item: tab)
                    }
            }
        }
        .frame(height: 64)
        .padding(6)
        .background(Color.clear)
    }
    
}

extension CustomTabBarView {
    
    private func tabView(item: TabBarItem) -> some View {
        VStack(spacing: 8) {
            Spacer()
            Image(selectedTab == item ? item.iconName + "-fill" : item.iconName)
                .font(.subheadline)
            Text(item.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(selectedTab == item ? Color("mainColor") : item.color)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func switchTabItem(item: TabBarItem) {
        withAnimation(.easeInOut) {
            selectedTab = item
        }
    }
}

//
//  CustomTabContainerView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/17.
//

import SwiftUI

struct CustomTabContainerView<Content: View>: View {
    
    @Binding
    var selection: TabBarItem
    
    @State
    private var tabs: [TabBarItem] = []
    
    let content: Content
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                content
            }
            CustomTabBarView(tabs: tabs, selectedTab: $selection)
        }
        .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
    
}

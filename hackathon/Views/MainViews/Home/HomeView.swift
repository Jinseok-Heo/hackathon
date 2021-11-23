//
//  ContentView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject
    var homeVM: HomeViewModel = HomeViewModel()
    
    private var radius: CGFloat = 83
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .top) {
                background
                VStack(alignment: .leading, spacing: 0) {
                    HomeTopView()
                        .padding(.leading, 22)
                        .padding(.bottom, 29)
                    divider
                    MentorRecommendView()
                        .padding(.leading, 22)
                        .padding([.top, .bottom], 32)
                    divider
                    HotCommutnityView()
                        .padding(.leading, 22)
                        .padding([.top, .bottom], 32)
                    divider
                    HotPickMentoringView()
                        .padding(.leading, 22)
                        .padding(.top, 32)
                        .padding(.bottom, 16)
                }
            }
        }
        .environmentObject(homeVM)
        .edgesIgnoringSafeArea(.top)
    }
}

// MARK: Components
extension HomeView {
    
    private var background: some View {
        Circle()
            .foregroundColor(Color("secondColor"))
            .frame(width: radius * 2, height: radius * 2)
            .position(x: UIScreen.main.bounds.maxX + 49 - radius, y: -40 + radius)
    }
    
    private var divider: some View {
        Rectangle()
            .frame(maxWidth: .infinity, maxHeight: 8)
            .foregroundColor(Color(hex: "#F8F8FA"))
    }
    
}

//
//  ContentView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

struct HomeView: View {
    
    private var radius: CGFloat = 83
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .top) {
                background
                VStack(alignment: .leading, spacing: 0) {
                    HomeTopView()
                    MentorRecommendView()
                    HotCommutnityView()
                    HotPickMentoringView()
                }
                .padding(.leading, 22)
            }
        }
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
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView()
    }
}

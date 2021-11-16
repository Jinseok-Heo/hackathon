//
//  HomeTopView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import SwiftUI

struct HomeTopView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            titleView
                .padding(.top, 56)
            comments
                .padding(.top, 23)
            Spacer().frame(minHeight: 20)
            contents
        }
    }
    
}

// MARK: - Components

extension HomeTopView {
    
    // Title view
    private var titleView: some View {
        ZStack {
            HStack(spacing: 3) {
                titleText
                titleImage
                Spacer()
                HStack(spacing: 20) {
                    Image(systemName: "bell.badge")
                    Image(systemName: "magnifyingglass")
                }
                    .padding(.trailing, 26)
            }
        }
    }
    
    // Title image
    private var titleImage: some View {
        ZStack(alignment: .bottomLeading) {
            Circle()
                .foregroundColor(Color("mainColor"))
                .frame(width: 20, height: 20)
                .offset(x: 5, y: -5)
            Circle()
                .foregroundColor(Color("secondColor"))
                .frame(width: 15, height: 15)
        }
        .offset(y: -3)
    }
    
    // Title text
    private var titleText: some View {
        Text("mentink")
            .font(Font.custom("ArimaMadurai-Black", size: 30))
            .foregroundColor(Color("mainColor"))
            .frame(height: 50)
    }
    
    // Top comments
    private var comments: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("다람이님,")
            HStack(spacing: 1) {
                Text("멘토와의 약속이")
                ZStack {
                    Circle()
                        .frame(width: 34, height: 34)
                        .foregroundColor(Color("secondColor"))
                    HStack(alignment: .bottom, spacing: 0) {
                        Text("3")
                            .font(Font.custom("Manrope-ExtraBold", size: 17))
                            .foregroundColor(Color("mainColor"))
                        Text("건")
                            .font(Font.custom("AppleSDGothicNeo-Bold", size: 11))
                            .padding(.bottom, 3)
                    }
                }
                Text("있어요.")
            }
        }
        .font(Font.custom("AppleSDGothicNeo-Bold", size: 20))
        
    }
    
    private var contents: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                ForEach(0..<5) { num in
                    MeetingCard(isOffline: num % 2 == 0)
                        .padding(6)
                        .shadow(color: Color(num % 2 == 0 ? "mainShadowColor" : "secondShadowColor"), radius: 3, x: 0, y: 0)
                }
            }
        }
        .offset(x: -3)
    }
    
}

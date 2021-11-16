//
//  ContentView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

struct HotPickMentoringView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("멘팅커들의 핫픽 멘토링")
                .font(Font.custom("AppleSDGothicNeo-Bold", size: 20))
                .padding(.top, 72)
            Text("전공/직무는 달라도 우리는 모두 요.즘.멘.티!")
                .font(Font.custom("AppleSDGothicNeo-SemiBold", size: 14))
                .foregroundColor(Color(hex: "#666666"))
                .padding(.top, 6)
            Spacer().frame(height: 20)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(1..<4) { idx in
                        MentoringCard(rank: idx, rating: 4.8, likedCount: 109, isOffline: idx % 2 == 1, title: "1 : 1 첨삭으로 자기소개서 합격을 위한 비결 대방출", name: "정찰기", job: "인사부과", years: 4)
                    }
                }
            }
            MoreRectangleBar(text: "더보기")
                .padding(.top, 20)
            Spacer()
        }
    }
    
}

struct HomeView: View {
    
    private var radius: CGFloat = 83
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .top) {
                background
                VStack(alignment: .leading, spacing: 0) {
                    titleView
                        .padding(.top, 56)
                    comments
                        .padding(.top, 23)
                    Spacer().frame(minHeight: 20)
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
    
    // Top circle
    private var background: some View {
        Circle()
            .foregroundColor(Color("secondColor"))
            .frame(width: radius * 2, height: radius * 2)
            .position(x: UIScreen.main.bounds.maxX + 49 - radius, y: -40 + radius)
    }
    
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
    
    //
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MyTabView()
    }
}

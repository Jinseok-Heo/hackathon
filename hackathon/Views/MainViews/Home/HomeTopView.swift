//
//  HomeTopView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import SwiftUI

struct HomeTopView: View {
    
    @EnvironmentObject
    var homeVM: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            titleView
                .padding(.top, 56)
            comments
                .padding(.top, 23)
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
            Text("반가워요 \(UserModel.user?.nickName ?? "Untitled") 님,")
            if UserModel.user?.verified == true {
                HStack(spacing: 1) {
                    Text("멘토와의 약속이")
                    ZStack {
                        Circle()
                            .frame(width: 34, height: 34)
                            .foregroundColor(Color("secondColor"))
                        HStack(alignment: .bottom, spacing: 0) {
                            Text(String(format: "%d", homeVM.meetings.count))
                                .font(FontManager.font(size: 17, weight: .bold))
                                .foregroundColor(Color("mainColor"))
                            Text("건")
                                .font(FontManager.font(size: 11, weight: .bold))
                                .padding(.bottom, 3)
                        }
                    }
                    Text("있어요.")
                }
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    Text("인증 후에 더 많은 기능을 이용할 수 있어요")
                        .font(FontManager.font(size: 17, weight: .bold))
                    Button {
                        self.homeVM.action = 1
                    } label: {
                        Text("이메일 인증 바로가기 >")
                            .font(FontManager.font(size: 15, weight: .semibold))
                    }
                }
            }
        }
        .font(FontManager.font(size: 20, weight: .bold))        
    }
    
    @ViewBuilder private var contents: some View {
        if UserModel.user?.verified == true {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(homeVM.meetings, id: \.self) { meeting in
                        MeetingCard(meeting: meeting, homeVM: homeVM)
                            .cornerRadius(4, corners: [.topRight, .bottomLeft, .bottomRight])
                            .padding(6)
                            .shadow(color: Color(meeting.untact == "true" ? "mainShadowColor" : "secondShadowColor"), radius: 3, x: 0, y: 0)
                    }
                }
            }
            .padding(.top, 20)
            .offset(x: -3)
        } else {
            EmptyView()
        }
    }
    
}

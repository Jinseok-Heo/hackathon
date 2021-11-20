//
//  HotPickMentoringView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import SwiftUI

struct HotPickMentoringView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            title
            subTitle
            Spacer().frame(height: 20)
            content
            moreButton
            Spacer()
        }
    }
    
}

extension HotPickMentoringView {
    
    private var title: some View {
        Text("멘팅커들의 핫픽 멘토링")
            .font(Font.custom("AppleSDGothicNeo-Bold", size: 20))
    }
    
    private var subTitle: some View {
        Text("전공/직무는 달라도 우리는 모두 요.즘.멘.티!")
            .font(Font.custom("AppleSDGothicNeo-SemiBold", size: 14))
            .foregroundColor(Color(hex: "#666666"))
            .padding(.top, 6)
    }
    
    private var content: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(1..<4) { idx in
                    MentoringCard(rank: idx, rating: 4.8, likedCount: 109, isOffline: idx % 2 == 1, title: "1 : 1 첨삭으로 자기소개서 합격을 위한 비결 대방출", name: "정찰기", job: "인사부과", years: 4)
                }
            }
        }
    }
    
    private var moreButton: some View {
        MoreRectangleBar(text: "더보기")
            .padding(.top, 20)
    }
    
}

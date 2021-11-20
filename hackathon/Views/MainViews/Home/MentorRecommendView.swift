//
//  MentorRecommendView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/15.
//

import SwiftUI

struct MentorRecommendView: View {
    
    private let dummyName: [String] = ["김윤비", "데이지", "마이크", "레이첼"]
    private let dummyRating: [Double] = [4.7, 4.8, 4.5, 4.7]
    private let dummyJobs: [String] = ["경영매니저", "경영컨설턴트", "호텔경영팀", "마케팅기획자"]
    private let dummyYears: [Int] = [2, 3, 3, 3]
    
    var body: some View {
        VStack(alignment: .leading) {
            title
            content
            moreButton
        }
    }
}

extension MentorRecommendView {
    
    private var title: some View {
        Text("추천 멘토")
            .font(Font.custom("AppleSDGothicNeo-Bold", size: 20))
    }
    
    private var content: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(0..<4) { idx in
                    MentoCard(name: dummyName[idx], rating: dummyRating[idx], job: dummyJobs[idx], years: dummyYears[idx])
                }
            }
        }
    }
    
    private var moreButton: some View {
        MoreRectangleBar(text: "멘토 더보기")
            .padding(.top, 19)
    }
    
}

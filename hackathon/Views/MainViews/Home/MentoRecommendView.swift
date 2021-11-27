//
//  MentorRecommendView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/15.
//

import SwiftUI

struct MentoRecommendView: View {
    
//    let mentos = Mento.getDummy()
    @EnvironmentObject
    var homeVM: HomeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            title
            content
            moreButton
        }
    }
}

extension MentoRecommendView {
    
    private var title: some View {
        Text("추천 멘토")
            .font(FontManager.font(size: 20, weight: .bold))
    }
    
    private var content: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(homeVM.recommendedMentor) { mento in
                    MentoCard(recommendedMento: mento)
                }
            }
        }
    }
    
    private var moreButton: some View {
        MoreRectangleBar(text: "멘토 더보기")
            .padding(.top, 19)
    }
    
}

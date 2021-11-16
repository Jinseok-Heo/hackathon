//
//  HotCommunityView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/15.
//

import SwiftUI

struct HotCommutnityView: View {
    
    @State
    var communitySelection: Int = 0
    
    private let dummyTitle: [String] = [
        "올해 상반기 공채 준비중인데",
        "이력서에 사진이요",
        "여러분 토익점수 몇 나오세요?"
    ]
    private let dummyContent: [String] = [
        "이번 여름방학 때 레벨업 하려고 하는데 학원보다 인강 결제가 싼 것 같던데 가나다ㅏ라라라",
        "요즘 이력서에는 사진 잘 안붙이는 블라인드 채용이 많다고 하던데 맞나요ㅠㅠ",
        "재작년에 토익을 봤었는데 좀더 점수를 올리고 싶어서 공부하고 있는데 조언구해요"
    ]
    private let dummyCommentCount: [Int] = [5, 3, 8]
    private let dummyLikedCount: [Int] = [34, 30, 35]
    private let dummyDisplayName: [String] = ["크로바", "다람이", "민냥펀치"]
    private let dummyMajor: [String] = ["경영마케팅", "국제경영", "경영"]
    private let dummyTimeInfo: [String] = ["1시간 전", "어제", "20201.09.22"]
    
    private let communityMenu: [String] = ["취업정보", "대외활동정보", "만나자 게더링", "자유주제"]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("커뮤니티 인기글")
                .font(Font.custom("AppleSDGothicNeo-Bold", size: 20))
                .padding(.top, 72)
            HStack {
                ForEach(0..<4) { idx in
                    Text(communityMenu[idx])
                        .foregroundColor(Color(hex: communitySelection == idx ? "#333333" : "#767676"))
                        .font(Font.custom(communitySelection == idx ? "AppleSDGothicNeo-Bold" : "AppleSDGothicNeo-SemiBold", size: 13))
                        .padding([.top, .bottom], 6)
                        .padding([.trailing, .leading], 9)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundColor(communitySelection == idx ? Color("secondColor") : Color(hex: "#F1F1F5"))
                        )
                        .onTapGesture {
                            withAnimation {
                                communitySelection = idx
                            }
                        }
                }
            }
            VStack {
                Spacer().frame(height: 10)
                ForEach(0..<3) { idx in
                    VStack(spacing: 8) {
                        CommunityCard(title: dummyTitle[idx],
                                      content: dummyContent[idx],
                                      commentCount: dummyCommentCount[idx],
                                      likedCount: dummyLikedCount[idx],
                                      displayName: dummyDisplayName[idx],
                                      major: dummyMajor[idx],
                                      timeInfo: dummyTimeInfo[idx])
                            .padding(.top, 12)
                        if idx != 2 {
                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(Color(hex: "#F3F3F3"))
                        }
                    }
                    .padding(.leading, 12)
                    .padding(.trailing, 34)
                }
            }
            MoreRectangleBar(text: "커뮤니티 더보기")
                .padding(.top, 19)
        }
    }
}

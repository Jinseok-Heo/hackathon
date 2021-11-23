//
//  MeetingCard.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

struct MeetingCard: View {
    
    private var roundedCorners: UIRectCorner = [.bottomLeft, .bottomRight, .topRight]
    
    private var name: String
    private var comment: String
    private var untact: Bool
    private var time: String
    
    public init(meeting: MatchingResponse) {
        self.time = DateManager.shared.dateDayInterval(before: Date(), after: meeting.time)
        self.name = DummyData.profiles.filter({ $0.userId == meeting.mentorId }).first!.nickName
        self.comment = DummyData.promotion.filter({ $0.mentoId == meeting.mentorId }).first!.description
        self.untact = meeting.untact
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                topView
                mentorInfo
                mentorComments
                    .padding(.top, 4)
                divider
                dateInfo
                Spacer()
            }
        }
        .frame(width: 200, height: 270)
        .cornerRadius(4, corners: roundedCorners)
        .background(.white)
    }
    
    private var topView: some View {
        HStack {
            Rectangle()
                .cornerRadius(16, corners: roundedCorners)
                .foregroundColor(Color(untact ? "secondColor" : "mainColor"))
                .frame(width: 114, height: 30)
                .overlay(
                    Text((untact ? "오프라인 ・ " : "온라인 ・ ") + time)
                        .font(FontManager.font(size: 14, weight: .bold))
                        .foregroundColor(untact ? Color(hex: "#1D1D1D") : .white)
                )
            Spacer()
        }
    }
    
    private var mentorInfo: some View {
        HStack(spacing: 6) {
            Circle()
                .frame(width: 40, height: 40)
                .foregroundColor(.gray)
                .padding(.leading, 18)
            VStack(alignment: .leading) {
                HStack(spacing: 2) {
                    Text(name)
                        .font(FontManager.font(size: 17, weight: .bold))
                    Text("멘토")
                        .font(FontManager.font(size: 13, weight: .bold))
                        .foregroundColor(Color(hex: "#555555"))
                }
                Text("금융사 마케터 2년차")
                    .font(Font.custom("AppleSDGothicNeo-Medium", size: 11))
                    .foregroundColor(Color(hex: "#555555"))
            }
            Spacer()
        }
    }
    
    private var mentorComments: some View {
        HStack {
            Text(comment)
                .foregroundColor(Color(hex: "#191919"))
                .font(FontManager.font(size: 15, weight: .bold))
        }
        .frame(maxWidth: 160, alignment: .leading)
        .padding(.leading, 18)
    }
    
    private var divider: some View {
        Rectangle()
            .foregroundColor(Color(hex: untact ? "#D2D7FD" : "#FFF3CA"))
            .frame(width: 164, height: 2)
            .padding(.leading, 18)
    }
    
    private var dateInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("2021.10.21 수요일")
            Text("오후 4시 20분(3시간)")
            Text(untact ? "추후 알림" : "자바커피 교대점")
        }
        .font(FontManager.font(size: 13, weight: .semibold))
        .padding(.leading, 18)
        .foregroundColor(Color(hex: "#555555"))
    }
}

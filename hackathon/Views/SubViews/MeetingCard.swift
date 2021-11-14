//
//  MeetingCard.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

struct MeetingCard: View {
    
    var isOffline: Bool
    
    private var roundedCorners: UIRectCorner = [.bottomLeft, .bottomRight, .topRight]
    
    private var name: String {
        if isOffline {
            return "김지원"
        } else {
            return "시드니"
        }
    }
    
    private var comment: String {
        if isOffline {
            return "금융사 마케터 신입\n지원 노하우 A to Z 코칭 원데이 클래스"
        } else {
            return "금융 데이터 3년차의 엑셀 차트 시각화 멘토링"
        }
    }
    
    public init(isOffline: Bool) {
        self.isOffline = isOffline
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
                .foregroundColor(Color(isOffline ? "mainColor" : "secondColor"))
                .frame(width: 114, height: 30)
                .overlay(
                    Text(isOffline ? "오프라인 ・ D-4" : "온라인 ・ D-10")
                        .font(Font.custom("AppleSDGothicNeo-Bold", size: 14))
                        .foregroundColor(isOffline ? .white : Color(hex: "#1D1D1D"))
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
                        .font(Font.custom("AppleSDGothicNeo-Bold", size: 17))
                    Text("멘토")
                        .font(Font.custom("AppleSDGothicNeo-Bold", size: 13))
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
                .font(Font.custom("AppleSDGothicNeo-Bold", size: 15))
        }
        .frame(maxWidth: 160, alignment: .leading)
        .padding(.leading, 18)
    }
    
    private var divider: some View {
        Rectangle()
            .foregroundColor(Color(hex: isOffline ? "#D2D7FD" : "#FFF3CA"))
            .frame(width: 164, height: 2)
            .padding(.leading, 18)
    }
    
    private var dateInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("2021.10.21 수요일")
            Text("오후 4시 20분(3시간)")
            Text(isOffline ? "자바커피 교대점" : "추후 알림")
        }
        .font(Font.custom("AppleSDGothicNeo-SemiBold", size: 13))
        .padding(.leading, 18)
        .foregroundColor(Color(hex: "#555555"))
    }
}

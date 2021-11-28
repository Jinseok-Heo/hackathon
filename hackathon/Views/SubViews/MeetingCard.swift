//
//  MeetingCard.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

struct MeetingCard: View {
    
    private var roundedCorners: UIRectCorner = [.bottomLeft, .bottomRight, .topRight]
    
    private let meeting: Schedule
    
    private var name: String
    private var untact: Bool
    private var time: String
    
    @State
    var toReview: Bool
    
    @ObservedObject
    var homeVM: HomeViewModel
    
    var year: String {
        if meeting.year == "0" {
            return "신입"
        } else {
            return "\(meeting.year)년차"
        }
    }
    
    var jobInfo: String {
        return "\(meeting.company) \(meeting.job) \(year)"
    }
    
    public init(meeting: Schedule, homeVM: HomeViewModel) {
        self.meeting = meeting
        self.time = DateManager.shared.dateDayInterval(before: Date(), after: meeting.appointmentTime.toDate())
        self.name = meeting.nickName
        self.untact = meeting.untact == "true" ? true : false
        self.toReview = false
        self.homeVM = homeVM
    }
    
    var body: some View {
        ZStack {
            NavigationLink(destination: ReviewPostingView(meeting: meeting, didSuccess: $homeVM.didChanged), isActive: $toReview) { EmptyView() }
            VStack(alignment: .leading, spacing: 16) {
                topView
                mentorInfo
                divider
                if meeting.appointmentTime.toDate() > Date() {
                    dateInfo
                } else {
                    reviewField
                }
                divider
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
                .foregroundColor(Color(untact ? "mainColor" : "secondColor"))
                .frame(width: 114, height: 30)
                .overlay(
                    Text((untact ? "온라인 ・ " : "오프라인 ・ ") + time)
                        .font(FontManager.font(size: 14, weight: .bold))
                        .foregroundColor(untact ? Color(hex: "#1D1D1D") : .white)
                )
            Spacer()
        }
    }
    
    private var mentorInfo: some View {
        HStack(spacing: 6) {
            Image(uiImage: meeting.profileImage.toImage()!)
                .resizable()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .padding(.leading, 18)
            VStack(alignment: .leading) {
                HStack(spacing: 2) {
                    Text(name)
                        .font(FontManager.font(size: 17, weight: .bold))
                    Text("멘토")
                        .font(FontManager.font(size: 13, weight: .bold))
                        .foregroundColor(Color(hex: "#555555"))
                }
                Text(jobInfo)
                    .font(Font.custom("AppleSDGothicNeo-Medium", size: 11))
                    .foregroundColor(Color(hex: "#555555"))
            }
            Spacer()
        }
    }
    
    private var divider: some View {
        Rectangle()
            .foregroundColor(Color(hex: untact ? "#D2D7FD" : "#FFF3CA"))
            .frame(width: 164, height: 2)
            .padding(.leading, 18)
    }
    
    private var dateInfo: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(meeting.appointmentTime.toDate().toFormattedString())
            Text(meeting.location == "null" ? "장소 정보 없음" : meeting.location)
        }
        .font(FontManager.font(size: 13, weight: .semibold))
        .padding(.leading, 18)
        .foregroundColor(Color(hex: "#191919"))
    }
    
    private var reviewField: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("멘토링은 어떠셨나요?")
                .font(FontManager.font(size: 16, weight: .semibold))
            Button {
                toReview = true
            } label: {
                Text("후기작성 바로가기 >")
            }
        }
        .font(FontManager.font(size: 14, weight: .semibold))
        .padding(.leading, 18)
        .foregroundColor(Color(hex: "#191919"))
    }
    
}

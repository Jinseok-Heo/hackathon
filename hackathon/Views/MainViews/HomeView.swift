//
//  ContentView.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

struct MentoCard: View {
    
    var name: String
    var rating: Double
    var job: String
    var years: Int
    
    public init(name: String, rating: Double, job: String, years: Int) {
        self.name = name
        self.rating = rating
        self.job = job
        self.years = years
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Circle()
                .foregroundColor(.gray)
                .frame(width: 70, height: 70)
                .padding(.top, 10)
            Text(name)
                .font(Font.custom("AppleSDGothicNeo-Bold", size: 14))
                .foregroundColor(Color(hex: "#111111"))
                .padding(.top, 6)
            HStack(spacing: 0) {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color("mainColor"))
                Text(String(format: "%.1f", rating))
                    .foregroundColor(.black)
                    .font(Font.custom("AppleSDGothicNeo-SemiBold", size: 11))
            }
            .padding(.top, 3)
            Text(job)
                .padding(.top, 5)
            Text(String(format: "%d년차", years))
            Spacer()
        }
        .frame(width: 110, height: 164)
        .padding(1)
        .foregroundColor(Color(hex: "#444444"))
        .font(Font.custom("AppleSDGothicNeo-Medium", size: 13))
        .background(Color(hex: "#F2F4F9"))
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .strokeBorder(Color(hex: "#E6EBF6"), lineWidth: 1)
        )
    }
}

struct MoreRectangleBar: View {

    var text: String
    
    public init(text: String) {
        self.text = text
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 4)
                .foregroundColor(Color(hex: "#ECECEC"))
            Text(text)
                .font(Font.custom("AppleSDGothicNeo-Bold", size: 14))
                .foregroundColor(Color(hex: "#555555"))
                .frame(maxHeight: .infinity, alignment: .center)
        }
        .padding(.trailing, 22)
        .frame(height: 36)
    }
}

struct HomeView: View {
    
    private var radius: CGFloat = 83
    private let dummyName: [String] = ["김윤비", "데이지", "마이크"]
    private let dummyRating: [Double] = [4.7, 4.8, 4.5]
    private let dummyJobs: [String] = ["경영매니저", "경영컨설턴트", "호텔경영팀"]
    private let dummyYears: [Int] = [2, 3, 3]
    
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
                    Text("추천 멘토")
                        .font(Font.custom("AppleSDGothicNeo-Bold", size: 20))
                        .padding(.top, 69)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(0..<3) { idx in
                                MentoCard(name: dummyName[idx], rating: dummyRating[idx], job: dummyJobs[idx], years: dummyYears[idx])
                            }
                        }
                    }
                    MoreRectangleBar(text: "멘토 더보기")
                        .padding(.top, 19)
                    Text("커뮤니티 인기글")
                        .font(Font.custom("AppleSDGothicNeo-Bold", size: 20))
                        .padding(.top, 72)
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

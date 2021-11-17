//
//  MentoringCard.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import SwiftUI

struct MentoringCard: View {
    
    var rank: Int
    var rating: Double
    var likedCount: Int
    var isOffline: Bool
    var title: String
    var name: String
    var job: String
    var years: Int
    
    public init(rank: Int,
                rating: Double,
                likedCount: Int,
                isOffline: Bool,
                title: String,
                name: String,
                job: String,
                years: Int) {
        self.rank = rank
        self.rating = rating
        self.likedCount = likedCount
        self.isOffline = isOffline
        self.title = title
        self.name = name
        self.job = job
        self.years = years
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack(alignment: .topLeading) {
                Rectangle()
                    .foregroundColor(.gray)
                    .cornerRadius(4, corners: [.bottomLeft, .bottomRight, .topRight])
                Rectangle()
                    .frame(width: 64, height: 30)
                    .cornerRadius(16, corners: [.bottomLeft, .bottomRight, .topRight])
                    .foregroundColor(Color("mainColor"))
                    .overlay(alignment: .leading) {
                        HStack(spacing: 0) {
                            Text("\(rank)")
                                .font(Font.custom("AppleSDGothicNeo-Bold", size: 14))
                                .foregroundColor(.white)
                                .padding(.leading, 14)
                            Image(systemName: "star.fill")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color("secondColor"))
                                .padding(.leading, 12)
                                .offset(y: -1)
                            Text(String(format: "%.1f", rating))
                                .font(Font.custom("AppleSDGothicNeo-SemiBold", size: 11))
                                .foregroundColor(.white)
                        }
                    }
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 0) {
                        VStack(spacing: 0) {
                            Image(systemName: "heart")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 20, height: 18, alignment: .topTrailing)
                            Text("\(likedCount)")
                                .font(Font.custom("AppleSDGothicNeo-SemiBold", size: 12))
                                .foregroundColor(.white)
                                .padding(.top, 5)
                        }
                        .shadow(color: Color(hex: "#000000").opacity(0.16), radius: 5, x: 0, y: 5)
                        Spacer()
                        Text(isOffline ? "오프라인" : "온라인")
                            .font(Font.custom("AppleSDGothicNeo-Bold", size: 12))
                            .foregroundColor(Color(hex: "#191919"))
                            .padding([.leading, .trailing], 4)
                            .padding([.top, .bottom], 2.5)
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .foregroundColor(Color("secondColor"))
                            )
                    }
                    .padding(.top, 7)
                    .padding([.bottom, .trailing], 8)
                }
            }
            .frame(width: 246, height: 142)
            Text(title)
                .foregroundColor(Color(hex: "#191919"))
                .font(Font.custom("AppleSDGothicNeo-Bold", size: 14))
                .frame(maxWidth: 194, minHeight: 34)
                .padding(.top, 12)
            HStack(spacing: 0) {
                Circle()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.gray)
                Text(name)
                    .padding(.leading, 6)
                    .padding(.trailing, 4)
                    .foregroundColor(Color(hex: "#111111"))
                    .font(Font.custom("AppleSDGothicNeo-Bold", size: 12))
                Text(job + " \(years)년차")
                    .foregroundColor(Color(hex: "#767676"))
                    .font(Font.custom("AppleSDGothicNeo-SemiBold", size: 12))
            }
            .padding(.top, 10)
        }
    }
    
}

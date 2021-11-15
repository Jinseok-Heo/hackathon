//
//  MentoCard.swift
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

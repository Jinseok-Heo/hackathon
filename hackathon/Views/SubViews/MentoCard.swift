//
//  MentoCard.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import SwiftUI

struct MentoCard: View {
    
    let recommendedMento: Recommend

    var body: some View {
        VStack(spacing: 0) {
            Image(uiImage: recommendedMento.profileImage.toImage() ?? UIImage(named: "userPlaceholder")!)
                .resizable()
                .frame(width: 70, height: 70)
                .clipShape(Circle())
                .padding(.top, 10)
            Text(recommendedMento.nickName)
                .font(FontManager.font(size: 14, weight: .bold))
                .foregroundColor(Color(hex: "#111111"))
                .padding(.top, 6)
            HStack(spacing: 0) {
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color("mainColor"))
                Text(String(format: "%.1f", recommendedMento.rating))
                    .foregroundColor(.black)
                    .font(FontManager.font(size: 11, weight: .semibold))
            }
            .padding(.top, 3)
            Text(recommendedMento.year)
                .padding(.top, 5)
            Text(String(format: "%d년차", recommendedMento.year))
            Spacer()
        }
        .frame(width: 110, height: 164)
        .padding(1)
        .foregroundColor(Color(hex: "#444444"))
        .font(FontManager.font(size: 13, weight: .medium))
        .background(Color(hex: "#F2F4F9"))
        .cornerRadius(4)
        .overlay(
            RoundedRectangle(cornerRadius: 4)
                .strokeBorder(Color(hex: "#E6EBF6"), lineWidth: 1)
        )
    }
}

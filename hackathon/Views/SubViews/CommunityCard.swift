//
//  CommunityCard.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/15.
//

import SwiftUI

struct CommunityCard: View {
    
    var title: String
    var content: String
    var commentCount: Int
    var likedCount: Int
    var displayName: String
    var major: String
    var timeInfo: String
    
    public init(title: String,
                content: String,
                commentCount: Int,
                likedCount: Int,
                displayName: String,
                major: String,
                timeInfo: String) {
        self.title = title
        self.content = content
        self.commentCount = commentCount
        self.likedCount = likedCount
        self.displayName = displayName
        self.major = major
        self.timeInfo = timeInfo
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text("Q.")
                    .foregroundColor(Color("mainColor"))
                Text(title)
                    .foregroundColor(Color(hex: "#191919"))
            }
            .font(FontManager.font(size: 14, weight: .bold))
            Text(content)
                .foregroundColor(Color(hex: "#555555"))
                .font(FontManager.font(size: 13, weight: .medium))
                .lineLimit(1)
            HStack(spacing: 0) {
                Image(systemName: "bubble.left")
                    .padding(.trailing, 1.5)
                Text(String(format: "%d", commentCount))
                    .padding(.trailing, 9)
                Image(systemName: "heart")
                    .padding(.trailing, 1.5)
                Text(String(format: "%d", likedCount))
                Spacer()
                Text("\(displayName) ・ \(major) ・ \(timeInfo)")
            }
            .foregroundColor(Color(hex: "#999999"))
            .font(FontManager.font(size: 12, weight: .medium))
        }
    }
}

//
//  CustomTabViewItem.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/17.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    
    case home, mentinker, community, chat, myPage
    
    var iconName: String {
        switch self {
        case .home:
            return "home"
        case .mentinker:
            return "mentinker"
        case .community:
            return "community"
        case .chat:
            return "chat"
        case .myPage:
            return "user"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "홈"
        case .mentinker:
            return "멘팅커"
        case .community:
            return "커뮤니티"
        case .chat:
            return "톡"
        case .myPage:
            return "마이페이지"
        }
    }
    
    var color: Color {
        switch self {
        case .home:
            return Color(hex: "#999999")
        case .mentinker:
            return Color(hex: "#999999")
        case .community:
            return Color(hex: "#999999")
        case .chat:
            return Color(hex: "#999999")
        case .myPage:
            return Color(hex: "#999999")
        }
    }
    
}

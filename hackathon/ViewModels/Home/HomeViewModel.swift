//
//  HomeViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/19.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published
    var todayMeetings: [MatchingResponse]
    @Published
    var recommendedMentor: [MentoResponse]
    @Published
    var hotCommunities: [BoardResponse]
    
    public init(user: UserResponse) {
        self.todayMeetings = []
        self.recommendedMentor = []
        self.hotCommunities = []
        getTodayMeetings(user: user)
        getRecommendedMentoes(user)
    }
    
    private func getTodayMeetings(user: UserResponse) {
        self.todayMeetings = DummyData.matching
            .filter({ $0.menteeId == user.id })
            .filter({ DateManager.shared.dateAsString(date: $0.time) == DateManager.shared.dateAsString() })
    }
    
    private func getRecommendedMentoes(_ : UserResponse) {
        self.recommendedMentor = DummyData.mentoes
    }
    
}

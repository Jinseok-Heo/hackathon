//
//  UserViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/16.
//

import SwiftUI

class UserViewModel {
    
    @Published
    var user: UserResponse
    @Published
    var todayMeetings: [MatchingResponse]
    
    public init() {
        user = DummyData.user
        todayMeetings = []
    }
    
    func getTodaysMeeting() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let meetings = DummyData.matching
            .filter({dateFormatter.string(from: Date()) == dateFormatter.string(from: $0.time) && user.id == $0.id})
        todayMeetings = meetings
    }
    
}

//
//  MeetingCardViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/22.
//

import SwiftUI

class MeetingCardViewModel: ObservableObject {
    
    @Published
    var meeting: MatchingResponse
    
    public var untact: String {
        return meeting.untact ? "온라인" : "오프라인"
    }
    
    
    
    public init(meeting: MatchingResponse) {
        self.meeting = meeting
    }
    
    
}

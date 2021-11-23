//
//  HomeViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/19.
//

import SwiftUI

class HomeViewModel: ObservableObject {

    @Published
    var user: UserResponse?
    @Published
    var profile: ProfileResponse?
    @Published
    var meetings: [MatchingResponse]
    @Published
    var recommendedMentor: [MentoResponse]
    @Published
    var hotCommunities: [BoardResponse]
    @Published
    var hotPickMentroings: [PromotionResponse]
    
    public init() {
        self.user = nil
        self.profile = nil
        self.meetings = []
        self.recommendedMentor = []
        self.hotCommunities = []
        self.hotPickMentroings = []
        
        getInfo()
    }
    
    public func getInfo() {
        getUser()
        getUserProfile()
        getMeetings()
        getRecommendedMentoes()
    }
    
    private func getUser() {
        let tokens = UserDefaultsManager.shared.getTokens()
        let verifiedToken = tokens.verifiedToken
        print(verifiedToken)
        self.user = DummyData.user
    }
    
    private func getUserProfile() {
        if let user = user {
            self.profile = DummyData.profiles.filter({ $0.userId == user.id }).first!
        }
    }
    
    private func getMeetings() {
        if let user = user {
            self.meetings = DummyData.matching
                .filter({ $0.menteeId == user.id })
                .filter { $0.time > Date() }
        }
    }
    
    private func getRecommendedMentoes() {
        self.recommendedMentor = DummyData.mentoes
    }
    
    private func getHotCommunities() {
        self.hotCommunities = DummyData.hotCommunities
    }
    
    private func getHotPickMentorings() {
        self.hotPickMentroings = DummyData.promotion
    }
    
}

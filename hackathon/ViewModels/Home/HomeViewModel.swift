//
//  HomeViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/19.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {

    @Published
    var cancellables = Set<AnyCancellable>()
    
    @Published
    var user: UserModel?
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
        self.meetings = []
        self.recommendedMentor = []
        self.hotCommunities = []
        self.hotPickMentroings = []
        
        getUserProfile()
        getInfo()
    }
    
    public func getInfo() {
        getUserProfile()
        getMeetings()
        getRecommendedMentoes()
    }
    
    public func getUserProfile() {
        AuthAPIService.getProfile(userId: SecurityManager.shared.load(account: .userID)!)
            .sink { result in
                switch result {
                case .finished:
                    NSLog("Successfully got user")
                case .failure(let error):
                    NSLog(error.localizedDescription)
                }
            } receiveValue: { user in
                self.user = user
                UserModel.saveUser(user: user)
            }
            .store(in: &cancellables)
    }
    
    private func getMeetings() {
        let userId = SecurityManager.shared.load(account: .userID)!
        
        self.meetings = DummyData.matching
            .filter({ $0.menteeId == Int(userId)! })
            .filter { $0.time > Date() }
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

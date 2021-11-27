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
    var meetings: Schedules
    @Published
    var recommendedMentor: Recommends
    @Published
    var hotCommunities: [BoardResponse]
    @Published
    var hotPickMentroings: [PromotionResponse]
    
    @Published
    var action: Int?
    
    public init() {
        self.user = nil
        self.meetings = []
        self.recommendedMentor = []
        self.hotCommunities = []
        self.hotPickMentroings = []
        self.action = 0
        
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
        HomeAPIService.getSchedule()
            .sink { result in
                switch result {
                case .finished:
                    print("scheule finished")
                case .failure(let err):
                    print(err.localizedDescription)
                }
            } receiveValue: { schedule in
                self.meetings = schedule
                print(self.meetings.count)
            }
            .store(in: &cancellables)
    }
    
    private func getRecommendedMentoes() {
        HomeAPIService.getList()
            .sink { result in
                switch result {
                case .finished:
                    print("recommend finished")
                case .failure(let err):
                    print(err.localizedDescription)
                }
            } receiveValue: { recommend in
                self.recommendedMentor = recommend
                print(recommend.count)
            }
            .store(in: &cancellables)
    }
    
    private func getHotCommunities() {
        self.hotCommunities = DummyData.hotCommunities
    }
    
//    private func getHotPickMentorings() {
//        self.hotPickMentroings = DummyData.promotion
//    }
    
}

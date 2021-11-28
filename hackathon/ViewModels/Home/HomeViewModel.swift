//
//  HomeViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/19.
//

import SwiftUI
import Combine

class ReviewFilter {
    
    static var postedReview: Schedules = []
    
}

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
    @Published
    var didChanged: Bool
    
    public init() {
        self.user = nil
        self.meetings = []
        self.recommendedMentor = []
        self.hotCommunities = []
        self.hotPickMentroings = []
        self.action = 0
        self.didChanged = false
        
        getInfo()
        addSubscriber()
    }
    
    private func addSubscriber() {
        $didChanged
            .sink { res in
                if res {
                    self.getMeetings()
                }
            }
            .store(in: &cancellables)
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
                self.meetings = schedule.filter({!ReviewFilter.postedReview.contains($0)}).sorted(by: {$0.appointmentTime < $1.appointmentTime})
                self.didChanged = false
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
            }
            .store(in: &cancellables)
    }
    
    private func getHotCommunities() {
        self.hotCommunities = DataSet.hotCommunities
    }

    
}

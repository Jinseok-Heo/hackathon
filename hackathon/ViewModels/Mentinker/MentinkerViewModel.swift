//
//  MentinkerViewModel.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/25.
//

import SwiftUI
import Combine

class MentinkerViewModel: ObservableObject {
    
    @Published
    var cancellabels = Set<AnyCancellable>()
    
    @Published
    var mentos: Mentos
    
    @Published
    var selectedItem: Mento?
    @Published
    var showDetail: Bool
    
    @Published
    var action: Int?
    @Published
    var isLoading: Bool
    @Published
    var alertTitle: String
    @Published
    var alertMsg: String
    @Published
    var showAlert: Bool
    
    public init() {
        self.mentos = []
        self.isLoading = false
        self.alertTitle = ""
        self.alertMsg = ""
        self.showAlert = false
        self.selectedItem = nil
        self.showDetail = false
        self.action = 0
        
        getMentoList()
    }
    
    public func getMentoList() {
        MentoAPIService.getMentoList()
            .sink { [weak self] result in
                switch result {
                case .finished:
                    NSLog("ViewModels/MentinkerViewModel/getMentoList Success")
                case .failure(let err):
                    self?.generateAlert(title: "오류 발생", message: "네트워크 연결을 확인해주세요")
                    NSLog(err.localizedDescription)
                }
            } receiveValue: { [weak self] mentos in
                self?.mentos = mentos
            }
            .store(in: &cancellabels)
    }
    
    public func getUserProfile() -> UserModel? {
        isLoading = true
        var ret: UserModel? = nil
        if let userID = SecurityManager.shared.load(account: .userID) {
            AuthAPIService.getProfile(userId: userID)
                .sink { [weak self] response in
                    self?.isLoading = false
                    switch response {
                    case .finished:
                        NSLog("ViewModels/MentinkerViewModel/getUserProfile Success")
                    case .failure(let error):
                        self?.generateAlert(title: "오류 발생", message: "네트워크 연결을 확인해주세요")
                        NSLog(error.localizedDescription)
                    }
                } receiveValue: { user in
                    ret = user
                }
                .store(in: &cancellabels)
        }
        return ret
    }
    
}

extension MentinkerViewModel {
    
    private func generateAlert(title: String, message: String) {
        alertTitle = title
        alertMsg = message
        showAlert = true
    }
    
}

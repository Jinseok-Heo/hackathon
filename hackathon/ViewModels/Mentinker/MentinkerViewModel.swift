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
        self.action = 0
        
        getMentoList()
    }
    
    public func getMentoList() {
        MatchingAPIService.getList()
            .sink { result in
                switch result {
                case .finished:
                    print("finished")
                case .failure(let err):
                    print(err.localizedDescription)
                }
            } receiveValue: { [weak self] mentos in
                self?.mentos = mentos
            }
            .store(in: &cancellabels)
    }
    
    public func getUserProfile(userId: Int) -> UserModel? {
        var ret: UserModel? = nil
        AuthAPIService.getProfile(userId: "\(userId)")
            .sink { [weak self] response in
                switch response {
                case .finished:
                    print("Get user completed")
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.generateAlert(title: "네트워크 오류 발생", message: "네트워크 연결을 확인해주세요")
                }
            } receiveValue: { user in
                ret = user
            }
            .store(in: &cancellabels)
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

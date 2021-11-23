//
//  UserDefualtsManager.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import Foundation

class UserDefaultsManager {
    
    enum Key: String, CaseIterable {
        case refreshToken, verifiedToken, userId
    }
    
    static let shared: UserDefaultsManager = UserDefaultsManager()
    
    func clearAll() {
        Key.allCases.forEach { UserDefaults.standard.removeObject(forKey: $0.rawValue) }
    }
    
    func setTokens(verifiedToken: String, refreshToken: String) {
        // TODO: Use Keychain to store tokens
        UserDefaults.standard.set(verifiedToken, forKey: Key.verifiedToken.rawValue)
        UserDefaults.standard.set(refreshToken, forKey: Key.refreshToken.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getTokens() -> AuthResponse {
        let verifiedToken = UserDefaults.standard.string(forKey: Key.verifiedToken.rawValue) ?? ""
        let refreshToken = UserDefaults.standard.string(forKey: Key.refreshToken.rawValue) ?? ""
        return AuthResponse(verifiedToken: verifiedToken, refreshToken: refreshToken)
    }
    
    func setUserId(userId: String) {
        UserDefaults.standard.set(userId, forKey: Key.userId.rawValue)
    }
    
    func getUserId() -> String {
        return UserDefaults.standard.string(forKey: Key.userId.rawValue) ?? ""
    }
    
}

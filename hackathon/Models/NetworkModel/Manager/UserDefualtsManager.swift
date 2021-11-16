//
//  UserDefualtsManager.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import Foundation

class UserDefaultsManager {
    
    enum Key: String, CaseIterable {
        case refreshToken, accessToken
    }
    
    static let shared: UserDefaultsManager = UserDefaultsManager()
    
    func clearAll() {
        Key.allCases.forEach { UserDefaults.standard.removeObject(forKey: $0.rawValue) }
    }
    
    /// Setting tokens
    func setTokens(accessToken: String, refreshToken: String) {
        // TODO: Use Keychain to store tokens
        UserDefaults.standard.set(accessToken, forKey: Key.accessToken.rawValue)
        UserDefaults.standard.set(refreshToken, forKey: Key.refreshToken.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getTokens() -> TokenResponse {
        let accessToken = UserDefaults.standard.string(forKey: Key.accessToken.rawValue) ?? ""
        let refreshToken = UserDefaults.standard.string(forKey: Key.refreshToken.rawValue) ?? ""
        return TokenResponse(accessToken: refreshToken, refreshToken: accessToken)
    }
    
}

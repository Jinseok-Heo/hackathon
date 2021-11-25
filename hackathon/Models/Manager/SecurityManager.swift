//
//  SecurityManager.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/14.
//

import Foundation
import Security
import Alamofire

class SecurityManager {
    
    static let shared = SecurityManager()
    
    private let serviceID = "com.jinseok.hackathon"
    
    enum Key: String, CaseIterable {
        case accessToken, refreshToken, userID
    }
    
    func save(account: Key, value: String) {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: self.serviceID,
            kSecAttrAccount: account.rawValue,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
        ]
        SecItemDelete(keyChainQuery)
        let status: OSStatus = SecItemAdd(keyChainQuery, nil)
        assert(status == noErr, "Can't save token")
        NSLog("\(status)")
    }
    
    func load(account: Key) -> String? {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: self.serviceID,
            kSecAttrAccount: account.rawValue,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(keyChainQuery, &dataTypeRef)
        
        if status == errSecSuccess {
            let retrievedData = dataTypeRef as! Data
            return String(data: retrievedData, encoding: .utf8)
        } else {
            NSLog("Can't load token")
            return nil
        }
    }
    
    func delete(account: Key) {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: self.serviceID,
            kSecAttrAccount: account.rawValue
        ]
        let status = SecItemDelete(keyChainQuery)
        assert(status == noErr, "Can't delete token")
        NSLog("\(status)")
    }
    
    func getAuthorizationHeader() -> HTTPHeaders? {
        if let accessToken = self.load(account: .accessToken) {
            return [HTTPHeader(name: "Authorization", value: "Bearer \(accessToken)")] as HTTPHeaders
        } else {
            return nil
        }
    }
    
    func deleteAll() {
        Key.allCases.forEach { key in
            delete(account: key)
        }
    }
    
}

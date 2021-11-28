//
//  StringExtension.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/20.
//

import SwiftUI

extension CharacterSet{
    
    static var modernHangul: CharacterSet{
        return CharacterSet(charactersIn: ("가".unicodeScalars.first!)...("힣".unicodeScalars.first!))
    }
    
}

extension String {
    
    /// Transform base64 encoded string to UIImage
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) {
            return UIImage(data: data)
        }
        return nil
    }
    
}

extension String {
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func decomposeHangul() -> String {
        return HangulDecomposer.getJamo(self)
    }
    
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, from <= to else {
            return ""
        }
        let start = self.index(startIndex, offsetBy: from)
        let end = self.index(startIndex, offsetBy: to + 1)
        return String(self[start..<end])
    }
    
}

extension String {
    
    /// Transform to date for request parameter
    func toDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.S"
        return dateFormatter.date(from: self)!
    }
    
}

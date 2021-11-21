//
//  StringExtension.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/20.
//

import Foundation

extension CharacterSet{
    static var modernHangul: CharacterSet{
        return CharacterSet(charactersIn: ("가".unicodeScalars.first!)...("힣".unicodeScalars.first!))
    }
}

extension String {
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func decomposeHangul() -> String {
        return HangulDecomposer.getJamo(self)
    }
    
}

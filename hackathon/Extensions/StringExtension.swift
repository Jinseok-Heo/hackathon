//
//  StringExtension.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/20.
//

import Foundation

extension String {
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
}

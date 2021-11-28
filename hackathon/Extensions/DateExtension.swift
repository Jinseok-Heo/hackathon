//
//  DateExtension.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/26.
//

import Foundation

extension Date {
    
    /// Transform to string for request parameter
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter.string(from: self)
    }
    
    /// Transform to formatted string
    func toFormattedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd EEEE"
        let d = dateFormatter.string(from: self)
        dateFormatter.dateFormat = "a hh시 mm분"
        let t = dateFormatter.string(from: self)
        return d + "\n" + t
    }
    
}

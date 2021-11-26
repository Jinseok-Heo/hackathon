//
//  DateExtension.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/26.
//

import Foundation

extension Date {
    
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"
        return dateFormatter.string(from: self)
    }
    
}

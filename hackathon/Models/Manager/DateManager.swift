//
//  DateManager.swift
//  hackathon
//
//  Created by Jinseok Heo on 2021/11/19.
//

import SwiftUI

final class DateManager {
    
    static var shared: DateManager = DateManager()
    
    func dateAsString(date: Date=Date()) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy.MM.dd EEEE"
        let d = dateFormatter.string(from: date)
        dateFormatter.dateFormat = "a hh시 mm분"
        let t = dateFormatter.string(from: date)
        return d + "\n" + t
    }
    
    func intervalFromToday(date: Date) -> String {
        return dateInterval(before: date, after: Date())
    }
    
    func dateDayInterval(before: Date, after: Date) -> String {
        if before < after {
            let dayInterval = Calendar.current.dateComponents([.day], from: before, to: after).day ?? 0
            if dayInterval == 0 {
                return "D-Day"
            } else {
                return String(format: "D-%d", dayInterval)
            }
        } else {
            let dayInterval = Calendar.current.dateComponents([.day], from: after, to: before).day ?? 0
            if dayInterval == 0 {
                return "D-Day"
            } else {
                return String(format: "D+%d", dayInterval)
            }
        }
        
    }
    
    func dateInterval(before: Date, after: Date) -> String {
        let yearInterval = Calendar.current.dateComponents([.year], from: before, to: after).year ?? 0
        if yearInterval > 0 {
            return String(format: "%d년 전", yearInterval)
        }
        let monthInterval = Calendar.current.dateComponents([.month], from: before, to: after).month ?? 0
        if monthInterval > 0 {
            return String(format: "%d달 전", monthInterval)
        }
        let dayInterval = Calendar.current.dateComponents([.day], from: before, to: after).day ?? 0
        if dayInterval > 1 {
            return String(format: "%d일 전", dayInterval)
        }
        let interval = after.timeIntervalSince(before)
        if interval < 60 {
            return String(format: "%d초 전", interval)
        } else if interval < 3600 {
            return String(format: "%d분 전", Int(interval / 60))
        } else if interval < 86400 {
            return String(format: "%d시간 전", Int(interval / 3600))
        } else {
            return "어제"
        }
    }

}

//
//  DateExtensions.swift
//  gv24App
//
//  Created by Macbook Solution on 6/1/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
extension Date{
    
    init(isoDateString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        let date = dateFormatter.date(from: isoDateString)!
        self = date
    }
    init(year : Int){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let string = "\(year)-12-31"
        let date = dateFormatter.date(from: string)!
        self = date
    }
    var year : String{
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: self)
        return "\(year)"
    }
    var isoString : String{
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter.string(from: self)
        
    }
    var month: String{
        let calendar = Calendar(identifier: .gregorian)
        let month = calendar.component(.month, from: self)
        return "\(month)"
    }
    var day: String{
        let calendar = Calendar(identifier: .gregorian)
        let day = calendar.component(.day, from: self)
        return "\(day)"
    }
    var monthYear: String {
        let calendar = Calendar(identifier: .gregorian)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        return "\(month)/\(year)"
    }
    var dayMonthYear : String{
        let calendar = Calendar(identifier: .gregorian)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        let day = calendar.component(.day, from: self)
        return "\(day)/\(month)/\(year)"
    }
    var yearMonthDate : String{
        let calendar = Calendar(identifier: .gregorian)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        let day = calendar.component(.day, from: self)
        return "\(year)/\(month)/\(day)"
    }

    
    var hour : String{
        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: self)
        return "\(hour)"
    }
    var minute: String{
        let calendar = Calendar(identifier: .gregorian)
        let minute = calendar.component(.minute, from: self)
        return "\(minute)"
    }
    var second: String{
        let calendar = Calendar(identifier: .gregorian)
        let second = calendar.component(.second, from: self)
        return "\(second)"
    }
    
    var hourMinute: String{
        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        return "\(hour)h\(minute)"
    }
    var hourMinuteSecond: String{
        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        let second = calendar.component(.second, from: self)
        return "\(hour)h\(minute)p\(second)"
    }
    
    var rangeDate: DateComponents{
        let toDate = Date()
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year , .month, .day, .hour, .minute, .second], from: self, to: toDate)
        return dateComponents
    }
    var compareDate: Bool{
        let currentDate = Date()
        switch self.compare(currentDate) {
        case .orderedAscending:
            return true
        case .orderedDescending:
            return false
        default:
            return false
        }
    }
    var periodTime: String{
        let dateComponent = self.rangeDate
        if dateComponent.month! > 0{
            return "\((dateComponent.month)!) \((LanguageManager.shared.localized(string: "MonthBefore"))!)"
        }else if dateComponent.day! > 0{
            return "\((dateComponent.day)!) \((LanguageManager.shared.localized(string: "DayBefore"))!)"
        }else if dateComponent.hour! > 0{
            return "\((dateComponent.hour)!) \((LanguageManager.shared.localized(string: "HourBefore"))!)"
        }
        return "\((dateComponent.minute)!) \((LanguageManager.shared.localized(string: "MinuteBefore"))!)"

    }
}

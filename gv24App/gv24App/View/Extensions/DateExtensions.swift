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
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 7)
        let date = dateFormatter.date(from: isoDateString)!
        print(isoDateString)
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
        formatter.locale = Locale(identifier: LanguageManager.shared.getCurrentLanguage().languageCode!)
        formatter.timeZone = TimeZone(secondsFromGMT: 7)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
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
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: LanguageManager.shared.getCurrentLanguage().languageCode!)
        formatter.dateFormat = "hh:mm a"
        let hourMinute = formatter.string(from: self)
        return hourMinute
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
    
    func postDefaultDate() -> Date{

        if Int(self.hour)! >= 22 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let string = "\(self.year)-\(self.month)-\(self.day)"
            var date = dateFormatter.date(from: string)!
            date = Date(timeInterval: 23 * 60 * 60 + (59 * 60), since: date)
            return date
        }
        let date = Date(timeInterval: 60 * 60 * 2, since: self)
        return date
    }
    
    var periodTime: String{
        let dateComponent = self.rangeDate
        if dateComponent.month! > 0{
            if dateComponent.month == 1{
                return "\((dateComponent.month)!) \((LanguageManager.shared.localized(string: "1MonthBefore"))!)"
            }
            return "\((dateComponent.month)!) \((LanguageManager.shared.localized(string: "MonthBefore"))!)"
            
        }else if dateComponent.day! > 0{
            if dateComponent.day == 1{
                return "\((dateComponent.day)!) \((LanguageManager.shared.localized(string: "1DayBefore"))!)"
            }
            return "\((dateComponent.day)!) \((LanguageManager.shared.localized(string: "DayBefore"))!)"
        }else if dateComponent.hour! > 0{
            return "\((dateComponent.hour)!) \((LanguageManager.shared.localized(string: "HourBefore"))!)"
        }
        return "\((dateComponent.minute)!) \((LanguageManager.shared.localized(string: "MinuteBefore"))!)"

    }
}

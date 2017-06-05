//
//  StringExtensions.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/3/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
extension String {
    static func heightWith(string: String, size : CGSize, font : UIFont) -> CGFloat{
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedRect = NSString(string: string).boundingRect(with: size, options: options, attributes: [NSFontAttributeName : font], context: nil)
        return estimatedRect.height
    }
    
    func htmlAttributedString(completion: ((_ string : NSAttributedString?)->())) {
        if let htmlData = self.data(using: String.Encoding(rawValue: String.Encoding.unicode.rawValue)){
            let attributedString = try! NSAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
            completion(attributedString)
        }else{
            completion(nil)
        }
    }
    
    var isEmail : Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        let emailTestResult = emailTest.evaluate(with: self)
        if !emailTestResult {
            return false
        }
        return true
    }
    var isPhoneNumber : Bool {
        let mobileFormat = "^(\\+\\d{1,3}[- ]?)?\\d{10}$"
        
        let mobileTest = NSPredicate(format: "SELF MATCHES %@", mobileFormat)
        let mobileTestResult = mobileTest.evaluate(with: self)
        if !mobileTestResult {
            return false
        }
        return true
    }
    

    
}

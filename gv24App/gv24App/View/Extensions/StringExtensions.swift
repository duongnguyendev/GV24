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
    
}

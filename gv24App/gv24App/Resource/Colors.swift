//
//  Colors.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/3/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{

    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static func rgbAlpha(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
}

class AppColor : NSObject{
    static let backButton = UIColor.rgb(red: 51, green: 197, blue: 205)
    static let backGround = UIColor.white
    static let homeButton1 = UIColor.rgb(red: 255, green: 191, blue: 65)
    static let homeButton2 = UIColor.rgb(red: 95, green: 216, blue: 27)
    static let homeButton3 = UIColor.rgb(red: 51, green: 197, blue: 205)
}

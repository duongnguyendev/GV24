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
    static let backgroundButtonHome = UIColor.rgb(red: 130, green: 130, blue: 130)
    static let backButton = UIColor.rgb(red: 19, green: 111, blue: 167)
class AppColor : NSObject {
    static let backButton = UIColor.rgb(red: 51, green: 197, blue: 205)
    static let backGround = UIColor.white
    static let homeButton1 = UIColor.rgb(red: 255, green: 191, blue: 65)
    static let homeButton2 = UIColor.rgb(red: 95, green: 216, blue: 27)
    static let homeButton3 = UIColor.rgb(red: 6, green: 110, blue: 169)
    static let collection = UIColor.white
    static let seqaratorView = UIColor.rgb(red: 230, green: 230, blue: 230)
    static let arrowRight = UIColor.rgb(red: 199, green: 199, blue: 204)
    static let white = UIColor.white
    static let lightGray = UIColor.lightGray
    static let icon = UIColor.lightGray
    static let facebook = UIColor.rgb(red: 65, green: 96, blue: 163)
    static let google = UIColor.rgb(red: 221, green: 74, blue: 56)
    static let colorButtonLogout = UIColor.rgb(red: 204, green: 204, blue: 204)
    static let titleButtonLogout = UIColor.rgb(red: 162, green: 162, blue: 162)
    static let buttonDelete = UIColor.rgb(red: 240, green: 19, blue: 77)
}

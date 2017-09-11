//
//  Icon.swift
//  gv24App
//
//  Created by dinhphong on 8/28/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
import IoniconsSwift

class Icon: NSObject {
    
    
    static let iconSizeDefault : CGFloat = 44
    
    static func by(name : Ionicons) -> UIImage{
        return name.image(iconSizeDefault)
    }
    static func by(name : Ionicons, size : CGFloat) -> UIImage{
        return name.image(size)
    }
    static func by(name : Ionicons, size : CGFloat, collor : UIColor) -> UIImage {
        return name.image(size, color: collor)
    }
    static func by(name: Ionicons, color : UIColor) -> UIImage{
        return name.image(iconSizeDefault, color: color)
    }
    static func by(imageName: String) -> UIImage?{
        return UIImage(named: imageName)
        
    }
    static var iconMarker = by(imageName: "marker_maid")?.resize(newWidth: 25)
}


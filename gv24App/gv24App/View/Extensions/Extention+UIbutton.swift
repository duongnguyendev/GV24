//
//  Extention+UIbutton.swift
//  gv24App
//
//  Created by HuyNguyen on 9/13/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation


extension UIButton{

    static func cornerButton(bt: UIButton) {
        bt.layer.cornerRadius = 8
        bt.layer.masksToBounds = true
    }
    
    static func corneRadius(bt: UIButton) {
        bt.layer.cornerRadius = 8
        bt.layer.masksToBounds = true
        bt.backgroundColor = AppColor.backButton
    }
    
    static func corneRadiusDelete(bt: UIButton) {
        bt.layer.cornerRadius = 8
        bt.layer.masksToBounds = true
        bt.backgroundColor = AppColor.buttonDelete
    }


}

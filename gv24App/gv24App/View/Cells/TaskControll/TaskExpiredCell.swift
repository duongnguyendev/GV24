//
//  TaskExpiredCell.swift
//  gv24App
//
//  Created by Macbook Solution on 5/30/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class TaskExpiredCell: TaskCell{
    
    let labelExpired : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.widthAnchor.constraint(equalToConstant: 70).isActive = true
        lb.heightAnchor.constraint(equalToConstant: 25).isActive = true
        lb.font = Fonts.by(name: .light, size: 13)
        lb.textColor = UIColor.white
        lb.backgroundColor = UIColor.lightGray
        
        lb.layer.cornerRadius = 12.5
        lb.layer.masksToBounds = true
        
        lb.textAlignment = .center
        lb.text = LanguageManager.shared.localized(string: "ExpiredTask")
        return lb
    }()
    override func setupView() {
        super.setupView()
        statusTask = LanguageManager.shared.localized(string: "ExpiredToApply")
        addSubview(labelExpired)
        labelExpired.rightAnchor.constraint(equalTo: rightAnchor, constant: -margin).isActive = true
        labelExpired.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
    }
}

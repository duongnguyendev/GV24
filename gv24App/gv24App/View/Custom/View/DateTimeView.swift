//
//  DateTimeView.swift
//  gv24App
//
//  Created by Macbook Solution on 5/25/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class DateTimeView: DescInfoView {
    var clock: String?{
        didSet{
            labelClock.text = clock
        }
    }
    let labelClock : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .light, size: 16)
        lb.textColor = .lightGray
        lb.text = "9:00 AM - 12:00 PM"
        return lb
    }()
    override func setupView() {
        super.setupView()
        addSubview(labelClock)
        labelClock.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        labelClock.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
    }
    
}

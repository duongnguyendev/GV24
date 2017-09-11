//
//  TaskRequestCell.swift
//  gv24App
//
//  Created by dinhphong on 6/27/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class TaskRequestCell: TaskCell{
    
    let labelRequest : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        //lb.widthAnchor.constraint(equalToConstant: 100).isActive = true
        lb.heightAnchor.constraint(equalToConstant: 25).isActive = true
        lb.font = Fonts.by(name: .light, size: 13)
        lb.textColor = UIColor.white
        
        lb.layer.cornerRadius = 12.5
        lb.layer.masksToBounds = true
        lb.backgroundColor = AppColor.homeButton1
        lb.textAlignment = .center
        lb.text = LanguageManager.shared.localized(string: "SentDirectly")
        return lb
    }()
    
    override func setupView() {
        super.setupView()
        statusTask = LanguageManager.shared.localized(string: "AwaitingAssignment")
        
        self.contentView.addSubview(labelRequest)
        marginTitle = 110
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[titleLabel]-8-[requestLabel]-8-|", options: [], metrics: nil, views: ["titleLabel": self.labelTitle, "requestLabel": self.labelRequest]))
        labelRequest.topAnchor.constraint(equalTo: topAnchor, constant: margin/3).isActive = true
    }
}

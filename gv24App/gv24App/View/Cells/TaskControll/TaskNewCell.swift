//
//  TaskPendingCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class TaskNewCell: TaskCell {

    let labelNumber : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.widthAnchor.constraint(equalToConstant: 20).isActive = true
        lb.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lb.font = Fonts.by(name: .light, size: 13)
        lb.textColor = UIColor.white
        lb.backgroundColor = UIColor.red
        
        lb.layer.cornerRadius = 10
        lb.layer.masksToBounds = true
        
        lb.textAlignment = .center
        lb.text = "2"
        return lb
    }()
    override func setupView() {
        super.setupView()
        addSubview(labelNumber)
        labelNumber.rightAnchor.constraint(equalTo: rightAnchor, constant: -margin).isActive = true
        labelNumber.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
    }
    
    
}

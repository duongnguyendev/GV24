//
//  MaidCell.swift
//  gv24App
//
//  Created by Macbook Solution on 6/7/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class MaidCell: BaseCollectionCell{
    let cellMargin : CGFloat = 20
    
    let profileRatingButton: ProfileRatingButton = {
        let button = ProfileRatingButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleButtonProfile(_:)), for: .touchUpInside)
        return button
    }()
    
    let horizontalLine = UIView.horizontalLine()
    
    let tasksButton: GeneralButton = {
       let button = GeneralButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleButtonTasks(_:)), for: .touchUpInside)
        button.title = "Danh sách công việc"
        button.color = AppColor.backButton
        return button
    }()
    
    
    override func setupView() {
        super.setupView()
        backgroundColor = UIColor.white
        addSubview(profileRatingButton)
        addSubview(horizontalLine)
        addSubview(tasksButton)
        
        addConstraintWithFormat(format: "V:|[v0(70)]", views: profileRatingButton)
        addConstraintWithFormat(format: "H:|[v0]|", views: profileRatingButton)
        
        horizontalLine.topAnchor.constraint(equalTo: profileRatingButton.bottomAnchor, constant: 0).isActive = true
        addConstraintWithFormat(format: "H:|[v0]|", views: horizontalLine)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: tasksButton)
        tasksButton.topAnchor.constraint(equalTo: horizontalLine.bottomAnchor, constant: 0).isActive = true
        tasksButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func handleButtonTasks(_ sender: UIButton){
        print("Click Button Comment")
    }
    
    func handleButtonProfile(_ sender: UIButton){
        print("Click Button Profile Ratting")
    }
}

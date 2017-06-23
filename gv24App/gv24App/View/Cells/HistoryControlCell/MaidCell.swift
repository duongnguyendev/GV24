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
    var delegate: HistoryVCDelegate?
    var title: String?{
        didSet{
            tasksButton.title = title
        }
    }
    let profileRatingButton: ProfileRatingButton = {
        let button = ProfileRatingButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let horizontalLine = UIView.horizontalLine()
    
    let tasksButton: GeneralButton = {
       let button = GeneralButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = LanguageManager.shared.localized(string: "Worklist")
        button.color = AppColor.backButton
        return button
    }()
    
    override func setupView() {
        super.setupView()
        backgroundColor = UIColor.white
        
        profileRatingButton.addTarget(self, action: #selector(handleButtonProfile(_:)), for: .touchUpInside)
        tasksButton.addTarget(self, action: #selector(handleButtonTasks(_:)), for: .touchUpInside)
        
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
        if delegate != nil{
            delegate?.selectedTaskMaid!(list: maidHistory!)
        }
    }
    func handleButtonProfile(_ sender: UIButton){
        if delegate != nil{
            delegate?.selectedProfile!(maid: maidHistory!)
        }
    }
    
    var maidHistory: MaidHistory?{
        didSet{
            profileRatingButton.str_Avatar = maidHistory?.avatarUrl
            profileRatingButton.name = maidHistory?.userName
            profileRatingButton.date = Date(isoDateString: (maidHistory?.times?[0])!).dayMonthYear
            profileRatingButton.ratingPoint = maidHistory?.evaluationPoint
        }
    }
}

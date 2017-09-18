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
    
    var cellMargin : CGFloat = 20
    weak var delegate: HistoryVCDelegate?
    
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
    
    var tasksButton: GeneralButton = {
       var button = GeneralButton()
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
        tasksButton.titleView.textAlignment = .left
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
            delegate?.handleTaskMaid!(list: maidHistory!)
        }
    }
    func handleButtonProfile(_ sender: UIButton){
        if delegate != nil{
            delegate?.handleProfile!(maid: maidHistory!)
        }
    }
    
    var maidHistory: MaidHistory? {
        didSet{
            profileRatingButton.str_Avatar = maidHistory?.avatarUrl
            profileRatingButton.name = maidHistory?.name
            profileRatingButton.date = Date(isoDateString: (maidHistory?.times?[0])!).dayMonthYear
            profileRatingButton.ratingPoint = maidHistory?.workInfo?.evaluationPoint
        }
    }
}







class MaidApplication: BaseCollectionCell{
    
    var cellMargin : CGFloat = 20
    weak var delegate: HistoryVCDelegate?
    
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
    
    var tasksButton: GeneralButton = {
        var button = GeneralButton()
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
        addSubview(tasksButton)
        tasksButton.titleView.textAlignment = .left
//        addConstraintWithFormat(format: "V:|[v0(80)]", views: profileRatingButton)
//        addConstraintWithFormat(format: "H:|[v0]|", views: profileRatingButton)
        
//        horizontalLine.topAnchor.constraint(equalTo: profileRatingButton.bottomAnchor, constant: 0).isActive = true
//        addConstraintWithFormat(format: "H:|[v0]|", views: horizontalLine)
        
//        addConstraintWithFormat(format: "H:|[v0]|", views: tasksButton)
        
        
        profileRatingButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profileRatingButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        profileRatingButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        profileRatingButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        
        
        tasksButton.topAnchor.constraint(equalTo: profileRatingButton.bottomAnchor, constant: 0).isActive = true
        tasksButton.centerYAnchor.constraint(equalTo: profileRatingButton.centerYAnchor, constant: 0).isActive = true
        tasksButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    func handleButtonTasks(_ sender: UIButton){
        if delegate != nil{
            delegate?.handleTaskMaid!(list: maidHistory!)
        }
    }
    func handleButtonProfile(_ sender: UIButton){
        if delegate != nil{
            delegate?.handleProfile!(maid: maidHistory!)
        }
    }
    
    var maidHistory: MaidHistory? {
        didSet{
            profileRatingButton.str_Avatar = maidHistory?.avatarUrl
            profileRatingButton.name = maidHistory?.name
            profileRatingButton.date = Date(isoDateString: (maidHistory?.times?[0])!).dayMonthYear
            profileRatingButton.ratingPoint = maidHistory?.workInfo?.evaluationPoint
        }
    }
}


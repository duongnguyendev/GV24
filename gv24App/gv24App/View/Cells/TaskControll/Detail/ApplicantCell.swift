//
//  ApplicantCell.swift
//  gv24App
//
//  Created by Macbook Solution on 6/12/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
@objc protocol ApplicantControlDelegate {
    @objc optional func selectedProfile(maid : MaidProfile)
    @objc optional func selectedMaid(maid : MaidProfile)
}

class ApplicantCell: MaidCell{
    var delegateApp: ApplicantControlDelegate?
    
    override func setupView() {
        super.setupView()
        title = "Chọn người giúp việc này"
    }
    
    override func handleButtonTasks(_ sender: UIButton) {
        if delegateApp != nil{
            delegateApp?.selectedMaid!(maid: (request?.madid)!)
        }
    }
    
    override func handleButtonProfile(_ sender: UIButton) {
        if delegateApp != nil{
            delegateApp?.selectedProfile!(maid: (request?.madid)!)
        }
    }
    
    var request: Request?{
        didSet{
            profileRatingButton.str_Avatar = request?.madid?.avatarUrl
            profileRatingButton.name = request?.madid?.userName
            profileRatingButton.date = "\((request?.madid?.workInfo?.price)!)"
        }
    }
}

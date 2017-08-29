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
    @objc optional func selectedMaid(id: String,maid : MaidProfile)
}
class ApplicantCell: MaidCell{
    var delegateApp: ApplicantControlDelegate?
    var idTask: String?
    override func setupView() {
        super.setupView()
        title = LanguageManager.shared.localized(string: "SelectYourApplicants")
    }
    
    override func handleButtonTasks(_ sender: UIButton) {
        if delegateApp != nil{
            delegateApp?.selectedMaid!(id: idTask!, maid: (request?.madid)!)
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
            profileRatingButton.name = request?.madid?.name
            let priceString = String.numberDecimalString(number: (request?.madid?.workInfo?.price)!)
            profileRatingButton.date = "\(priceString) VND/1 \(LanguageManager.shared.localized(string: "Hour")!)"
            profileRatingButton.ratingPoint = request?.madid?.workInfo?.evaluationPoint as? Double
        }
    }
}

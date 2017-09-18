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
    weak var delegateApp: ApplicantControlDelegate?
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
            profileRatingButton.ratingPoint = request?.madid?.workInfo?.evaluationPoint
        }
    }
}


protocol SelectApplicantCellDelegate: class {
    func didSelectItemAtIndex(cell: SelectApplicantCell, img: UIImageView)
}

class SelectApplicantCell: UICollectionViewCell {
    weak var delegate: SelectApplicantCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addComponents()
        self.addConstraints()
        let tapRecognizer = UITapGestureRecognizer(target: self, action:  #selector(imageTapped(_:)))
        avatarImageView.addGestureRecognizer(tapRecognizer)
    }
    func imageTapped(_ tap: UITapGestureRecognizer) {
        delegate?.didSelectItemAtIndex(cell: self, img: avatarImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let avatarImageView : UIImageView = {
        let avatarImageView = UIImageView()
        avatarImageView.contentMode = .scaleToFill
        avatarImageView.layer.cornerRadius = 62 / 2
        avatarImageView.layer.masksToBounds = true
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return avatarImageView
    }()
    
    private let nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 11.0)
        nameLabel.textColor = UIColor.black
        nameLabel.textAlignment = .center
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.numberOfLines = 2
        
        return nameLabel
    }()
    
    private func addComponents() {
        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.nameLabel)
        
        self.contentView.layer.cornerRadius = 10.0
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.init(red: 186/255, green: 183/255, blue: 183/255, alpha: 0.2).cgColor
    }
    
    private func addConstraints() {
        let views = ["avatar" : self.avatarImageView, "label": self.nameLabel]
        
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[avatar(62)]-10-[label]", options: [], metrics: nil, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-13-[label]-13-|", options: [], metrics: nil, views: views))
        self.contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[avatar(62)]", options: [], metrics: nil, views: views))
        self.contentView.addConstraint(NSLayoutConstraint.init(item: self.avatarImageView, attribute: .centerX, relatedBy: .equal, toItem: self.contentView, attribute: .centerX, multiplier: 1.0, constant: 0.0))
        
    }
    
    var request: Request?{
        didSet{
            self.nameLabel.text = self.request?.madid?.name
            guard let url = self.request?.madid?.avatarUrl else { return }
            self.avatarImageView.loadImageurl(link: url)
        }
    }    
}

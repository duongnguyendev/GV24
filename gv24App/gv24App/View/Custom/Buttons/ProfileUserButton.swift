//
//  ProfileButton.swift
//  gv24App
//
//  Created by Macbook Solution on 5/26/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class ProfileUserButton: BaseButton{
    let cellMargin : CGFloat = 20
    
    var received: MaidProfile?{
        didSet{
            avatarImageView.loadImageurl(link: (received?.avatarUrl)!)
            labelName.text = received?.userName
            labelAddress.text = received?.address?.name
        }
    }
    private let avatarImageView : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "avatar"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 25
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let labelName : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .medium, size: 18)
        lb.text = "Nguyễn Văn A"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let labelAddress : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 13)
        lb.text = "244 Cống Quỳnh, P. Phạm Ngũ Lão, Q.1"
        lb.numberOfLines = 2
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let arrowRight : UIImageView = {
        let iv = UIImageView(image: Icon.by(name: .iosArrowRight, color: AppColor.arrowRight))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    override func setupView() {
        super.setupView()
        backgroundColor = UIColor.white
        
        addSubview(avatarImageView)
        addSubview(labelName)
        addSubview(labelAddress)
        addSubview(arrowRight)
        
        avatarImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        labelName.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: cellMargin / 2).isActive = true
        labelName.rightAnchor.constraint(equalTo: arrowRight.leftAnchor, constant: 0).isActive = true
        labelName.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 0).isActive = true
        
        arrowRight.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        arrowRight.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        arrowRight.widthAnchor.constraint(equalToConstant: 20).isActive = true
        arrowRight.heightAnchor.constraint(equalToConstant: 20).isActive = true

        
        labelAddress.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: cellMargin / 2).isActive = true
        labelAddress.rightAnchor.constraint(equalTo: arrowRight.leftAnchor, constant: 0).isActive = true
        labelAddress.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 0).isActive = true
    }
}


//
//  ProfileButton.swift
//  gv24App
//
//  Created by Macbook Solution on 5/26/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class ProfileButton: BaseButton{

    let margin : CGFloat = 10.0
    
    private let avatarImage : CustomImageView = {
        let iconSize : CGFloat = 60
        let iv = CustomImageView(image : UIImage(named: "avatar"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        iv.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = iconSize/2
        return iv
    }()

    private let labelName : UIView = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .medium, size: 16)
        lb.text = "Nguyễn Văn A"
        return lb
    }()

    private let labelPrice : UIView = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .regular, size: 13)
        lb.text = "123 Đường 1,Quận 1,TP.Hồ Chí Minh"
        return lb
    }()

    private let iconArrowRight : IconView = {
        let iv = IconView(icon: .iosArrowForward, size: 20, color: UIColor.rgb(red: 199, green: 199, blue: 204))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func setupView() {
        super.setupView()
        backgroundColor = UIColor.white
        
        addSubview(avatarImage)
        addSubview(labelName)
        addSubview(labelPrice)
        addSubview(iconArrowRight)
        
        avatarImage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        avatarImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        
        labelName.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: margin).isActive = true
        labelName.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: margin).isActive = true
        
        labelPrice.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: margin - 2).isActive = true
        labelPrice.bottomAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: -5).isActive = true
        
        iconArrowRight.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        iconArrowRight.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true

    }
    
    
}

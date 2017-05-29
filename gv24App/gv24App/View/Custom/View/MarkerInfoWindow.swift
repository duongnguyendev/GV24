//
//  MarkerInfoWindow.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/18/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import IoniconsSwift

class MarkerInfoWindow: BaseView {

    var user : MaidProfile?{
        didSet{
            self.labelName.text = user?.userName
            self.labelPrice.text = "\(String(describing: (user?.workInfo?.price)!))"
        }
    }
    let margin : CGFloat = 5.0
    private let avatarImage : CustomImageView = {
        let iconSize : CGFloat = 40
        
        let iv = CustomImageView(image : UIImage(named: "avatar"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        iv.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = iconSize/2
        return iv
    }()
    
    private let labelName : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .medium, size: 14)
        lb.text = "Nguyễn Văn A"
        return lb
    }()

    private let labelPrice : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .light, size: 12)
        lb.text = "150.000 VND/giờ"
        return lb
    }()
    
    private let iconUSD : IconView = {
        let iv = IconView(icon: .socialUsd, size: 12, color: AppColor.backButton)
        
        return iv
    }()
    
    private let horizontalLine = UIView.horizontalLine()
    
    override func setupView() {
        backgroundColor = UIColor.white
        addSubview(avatarImage)
        addSubview(labelName)
        addSubview(iconUSD)
        addSubview(labelPrice)
        addSubview(horizontalLine)
        
        avatarImage.topAnchor.constraint(equalTo: self.topAnchor, constant: margin).isActive = true
        avatarImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: margin).isActive = true
        
        labelName.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: margin).isActive = true
        labelName.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 2).isActive = true
        
        iconUSD.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: margin - 2).isActive = true
        iconUSD.bottomAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: -2).isActive = true
        
        labelPrice.centerYAnchor.constraint(equalTo: iconUSD.centerYAnchor, constant: 0).isActive = true
        labelPrice.leftAnchor.constraint(equalTo: iconUSD.rightAnchor, constant: 2).isActive = true
        
        horizontalLine.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: margin).isActive = true
        addConstraintWithFormat(format: "H:|[v0]|", views: horizontalLine)
        
    }
}

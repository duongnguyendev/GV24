//
//  ProfileRatingButton.swift
//  gv24App
//
//  Created by Macbook Solution on 6/8/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class ProfileRatingButton: BaseButton{
    let cellMargin : CGFloat = 20
    
    var name: String?{
        didSet{
            labelName.text = name
        }
    }
    
    var date: String?{
        didSet{
            labelDate.text = date
        }
    }
    
    var str_Avatar: String?{
        didSet{
            avatarImageView.loadImageUsingUrlString(urlString: str_Avatar!)
        }
    }
    
    var ratingPoint: Int? {
        didSet{
            rattingView.point = ratingPoint
        }
    }
    var avatarImageView : CustomImageView = {
        var iv = CustomImageView(image: UIImage(named: "avatar"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 25
        
        iv.layer.masksToBounds = true
        return iv
    }()
    
    var labelName : UILabel = {
        var lb = UILabel()
        lb.font = Fonts.by(name: .medium, size: 18)
        lb.text = "Nguyễn Văn A"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var labelDate : UILabel = {
        var lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 13)
        lb.text = "12/03/2016"
        lb.textColor = AppColor.lightGray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    var arrowRight : UIImageView = {
        var iv = UIImageView(image: Icon.by(name: .iosArrowRight, color: AppColor.arrowRight))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let rattingView = RatingStartView()
    
    override func setupView() {
        super.setupView()
        backgroundColor = UIColor.white
        addSubview(avatarImageView)
        addSubview(labelName)
        addSubview(labelDate)
        addSubview(arrowRight)
        addSubview(rattingView)
       
        avatarImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        //avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        //avatarImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        
        labelName.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: cellMargin / 2).isActive = true
        labelName.rightAnchor.constraint(equalTo: arrowRight.leftAnchor, constant: 0).isActive = true
        labelName.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: cellMargin / 4).isActive = true
        
        arrowRight.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -(cellMargin/2)).isActive = true
        arrowRight.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 0).isActive = true
        arrowRight.widthAnchor.constraint(equalToConstant: 20).isActive = true
        arrowRight.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        labelDate.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: cellMargin / 2).isActive = true
        labelDate.rightAnchor.constraint(equalTo: arrowRight.leftAnchor, constant: 0).isActive = true
        labelDate.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -(cellMargin / 4)).isActive = true
        
        rattingView.rightAnchor.constraint(equalTo: rightAnchor, constant: -(cellMargin + 10)).isActive = true
        rattingView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 0).isActive = true
    }
}

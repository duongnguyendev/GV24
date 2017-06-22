//
//  MoreUserCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/4/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class BaseMoreCell: BaseCollectionCell {
    let cellMargin : CGFloat = 20
    let seqaratorView: UIView = {
        let view = UIView.horizontalLine()
        view.backgroundColor = AppColor.seqaratorView
        return view
    }()
    let arrowRight : UIImageView = {
        let iv = UIImageView(image: Icon.by(name: .iosArrowRight, color: AppColor.arrowRight))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    override func setupView() {
        backgroundColor = UIColor.white
        
        addSubview(arrowRight)
        addSubview(seqaratorView)
        
        seqaratorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        addConstraintWithFormat(format: "|-\(cellMargin)-[v0]|", views: seqaratorView)
        
        arrowRight.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        arrowRight.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        arrowRight.widthAnchor.constraint(equalToConstant: 20).isActive = true
        arrowRight.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}

class MoreUserCell: BaseMoreCell {
    
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
        lb.text = "244 Cống Quỳnh, p. Phạm Ngũ Lão, Q.1"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override func setupView() {
        super.setupView()
        addSubview(avatarImageView)
        addSubview(labelName)
        addSubview(labelAddress)
        
        avatarImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        avatarImageView.leftAnchor.constraint(equalTo: seqaratorView.leftAnchor, constant: 0).isActive = true
        avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        labelName.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: cellMargin / 2).isActive = true
        labelName.rightAnchor.constraint(equalTo: arrowRight.leftAnchor, constant: 0).isActive = true
        labelName.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 0).isActive = true
        
        labelAddress.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: cellMargin / 2).isActive = true
        labelAddress.rightAnchor.constraint(equalTo: arrowRight.leftAnchor, constant: 0).isActive = true
        labelAddress.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 0).isActive = true
        
        showUserInfo()
        
    }
    private func showUserInfo(){
        let user = UserHelpers.currentUser
        if let imageUrl = user?.avatarUrl{
            self.avatarImageView.loadImageurl(link: imageUrl)
        }
        
        self.labelName.text = user?.name
        self.labelAddress.text = user?.address?.name
        
    }
    
    
}

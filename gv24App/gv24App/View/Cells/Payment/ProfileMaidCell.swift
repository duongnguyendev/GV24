//
//  ProfileMaidCell.swift
//  gv24App
//
//  Created by dinhphong on 6/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class ProfileMaidCell: BaseCollectionCell{
    let cellMargin: CGFloat = 20
    var maid: MaidProfile? {
        didSet{
            labelName.text = maid?.name
            labelAddress.text = maid?.address?.name
            
            guard let urlString = maid?.avatarUrl else { return }
            guard let url = URL.init(string: urlString) else { return }
            self.avatarImageView.af_setImage(withURL: url)
        }
    }
    private let avatarImageView : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "avatar"))
        iv.contentMode = .scaleAspectFill
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
        lb.font = Fonts.by(name: .light, size: 12)
        lb.text = "244 Cống Quỳnh, P. Phạm Ngũ Lão, Q.1"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    /*private let arrowRight : UIImageView = {
        let iv = UIImageView(image: Icon.by(name: .iosArrowRight, color: AppColor.arrowRight))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()*/
    
    override func setupView() {
        super.setupView()
        backgroundColor = UIColor.white
        
        addSubview(avatarImageView)
        addSubview(labelName)
        addSubview(labelAddress)
        //addSubview(arrowRight)
        
        avatarImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        labelName.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: cellMargin / 2).isActive = true
        labelName.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 10).isActive = true
        labelName.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 0).isActive = true
        
        /*arrowRight.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        arrowRight.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        arrowRight.widthAnchor.constraint(equalToConstant: 20).isActive = true
        arrowRight.heightAnchor.constraint(equalToConstant: 20).isActive = true*/
        
        labelAddress.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: cellMargin/2).isActive = true
        labelAddress.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: -cellMargin/4).isActive = true

    }
    
}

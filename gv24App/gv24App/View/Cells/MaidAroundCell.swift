//
//  MaidAroundCell.swift
//  gv24App
//
//  Created by dinhphong on 9/13/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit


class MaidAroundCell: BaseCollectionCell {
    
    let cellMargin : CGFloat = 20
    
    var maid: MaidProfile? {
        
        didSet{
            if let maid = maid {
                labelName.text = maid.name
                labelAge.text = "Age: \(maid.age ?? 0)"
                labelPrice.text = "\(String.numberDecimalString(number: maid.workInfo?.price ?? 0)) VND/ giờ"
                if maid.calculated! >= 1000 {
                    labelDistance.text = "\(maid.calculated! / 1000) km"
                }else {
                      labelDistance.text = "\(maid.calculated ?? 0) m"
                }
                rattingView.point = maid.workInfo?.evaluationPoint
                guard let avt = maid.avatarUrl else {
                    return
                }
                avatarImageView.loadImageUsingUrlString(urlString: avt)
            }
        }
    }
    
    /*var name: String?{
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
    }*/
    
    private let avatarImageView : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "avatar"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 30
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
    
    private let labelPrice : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 13)
        lb.text = "150.000 VND /giờ"
        lb.textColor = AppColor.lightGray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let labelDistance: UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 13)
        lb.text = "20 m"
        lb.textColor = AppColor.lightGray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let arrowRight : UIImageView = {
        let iv = UIImageView(image: Icon.by(name: .iosArrowRight, color: AppColor.arrowRight))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let labelAge: UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 13)
        lb.text = "25 age"
        lb.textColor = AppColor.lightGray
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let rattingView = RatingStartView()
    
    override func setupView() {
        super.setupView()
        backgroundColor = AppColor.white
        addSubview(avatarImageView)
        addSubview(labelName)
        addSubview(labelPrice)
        addSubview(labelDistance)
        addSubview(arrowRight)
        addSubview(rattingView)
        addSubview(labelAge)
        
        avatarImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        labelName.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: cellMargin / 2).isActive = true
        labelName.rightAnchor.constraint(equalTo: rattingView.leftAnchor, constant: -5).isActive = true
        labelName.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 0).isActive = true
        
        arrowRight.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -(cellMargin/2)).isActive = true
        arrowRight.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        arrowRight.widthAnchor.constraint(equalToConstant: 20).isActive = true
        arrowRight.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        labelPrice.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: cellMargin / 2).isActive = true
        labelPrice.rightAnchor.constraint(equalTo: arrowRight.leftAnchor, constant: 0).isActive = true
        labelPrice.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 2).isActive = true
        labelPrice.bottomAnchor.constraint(equalTo: labelDistance.topAnchor, constant: 2).isActive = true
        
        labelDistance.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: cellMargin / 2).isActive = true
        labelDistance.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 0).isActive = true
        
        rattingView.rightAnchor.constraint(equalTo: rightAnchor, constant: -(cellMargin + 10)).isActive = true
        rattingView.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 10).isActive = true
        
        labelAge.centerXAnchor.constraint(equalTo: rattingView.centerXAnchor, constant: 0).isActive = true
        labelAge.topAnchor.constraint(equalTo: rattingView.bottomAnchor, constant: 5).isActive = true
    }

}

//
//  UserProfileCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/30/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import IoniconsSwift

class UserProfileCell: BaseCollectionCell {

    private var user : User?{
        didSet{
            avatarImageView.loadImageurl(link: (user?.avatarUrl)!)
            labelName.text = user?.name
            if user?.gender == 0{
                labelGender.text = LanguageManager.shared.localized(string: "Male")
            }else{
                labelGender.text = LanguageManager.shared.localized(string: "Female")
            }
            labelPhone.text = user?.phone
            labelAddress.text = user?.address?.name
            self.ratingView.point = 5
        }
    }
    let ratingView = RatingStartView()
    let imageBackGround : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "top_bg"))
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    let avatarImageView : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "avatar"))
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 80).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 80).isActive = true
        iv.layer.cornerRadius = 40
        iv.layer.masksToBounds = true
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 2
        return iv
    }()
    
    let labelName : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .medium, size: 17)
        lb.textColor = UIColor.white
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let labelGender : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let labelPhone : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let labelAddress : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        return lb
    }()
    
    let iconGender = IconView(icon: .transgender, size: 15, color: AppColor.backButton)
    let iconPhone = IconView(icon: .androidPhonePortrait, size: 15, color: AppColor.backButton)
    let iconAddress = IconView(icon: .home, size: 15, color: AppColor.backButton)
    let genderLine = UIView.horizontalLine()
    let phoneLine = UIView.horizontalLine()
    
    func addSubview() {
        addSubview(imageBackGround)
        addSubview(avatarImageView)
        addSubview(labelName)
        addSubview(ratingView)
        addSubview(iconPhone)
        addSubview(iconGender)
        addSubview(iconAddress)
        addSubview(labelGender)
        addSubview(labelPhone)
        addSubview(labelAddress)
        addSubview(genderLine)
        addSubview(phoneLine)
        
    }
    
    func setupComponent(){
        setupTopView()
        setupBottomView()

    }
    
    func setupTopView(){
        
        imageBackGround.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        imageBackGround.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imageBackGround.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        imageBackGround.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        avatarImageView.topAnchor.constraint(equalTo: imageBackGround.topAnchor, constant: 15).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: imageBackGround.centerXAnchor, constant: 0).isActive = true
        
        labelName.centerXAnchor.constraint(equalTo: imageBackGround.centerXAnchor, constant: 0).isActive = true
        labelName.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10).isActive = true
        
        ratingView.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 10).isActive = true
        ratingView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
    }
    
    func setupIcon(){
        iconGender.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        iconPhone.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        iconAddress.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        iconGender.rightAnchor.constraint(equalTo: labelGender.leftAnchor, constant: -10).isActive = true
        iconPhone.rightAnchor.constraint(equalTo: labelPhone.leftAnchor, constant: -10).isActive = true
        iconAddress.rightAnchor.constraint(equalTo: labelAddress.leftAnchor, constant: -10).isActive = true
        
        iconAddress.centerYAnchor.constraint(equalTo: labelAddress.centerYAnchor, constant: 0).isActive = true
        iconPhone.centerYAnchor.constraint(equalTo: labelPhone.centerYAnchor, constant: 0).isActive = true
        iconGender.centerYAnchor.constraint(equalTo: labelGender.centerYAnchor, constant: 0).isActive = true
        
        phoneLine.topAnchor.constraint(equalTo: labelPhone.bottomAnchor, constant: 0).isActive = true
        phoneLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        phoneLine.leftAnchor.constraint(equalTo: labelPhone.leftAnchor, constant: 0).isActive = true
        
        genderLine.topAnchor.constraint(equalTo: labelGender.bottomAnchor, constant: 0).isActive = true
        genderLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        genderLine.leftAnchor.constraint(equalTo: labelGender.leftAnchor, constant: 0).isActive = true
    
    }
    func setupBottomView(){
        setupIcon()
        
        labelGender.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelGender.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelGender.topAnchor.constraint(equalTo: imageBackGround.bottomAnchor, constant: 0).isActive = true
        
        labelPhone.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelPhone.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelPhone.topAnchor.constraint(equalTo: labelGender.bottomAnchor, constant: 0).isActive = true
        
        labelAddress.heightAnchor.constraint(equalToConstant: 50).isActive = true
        labelAddress.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelAddress.topAnchor.constraint(equalTo: labelPhone.bottomAnchor, constant: 0).isActive = true
    }
    
    override func setupView() {
        self.backgroundColor = UIColor.white
        getUserInfo()
        addSubview()
        setupComponent()
    }
    func getUserInfo(){
//        UserService.shared.getMyInfo { (user, error) in
//            if error == nil{
//                self.user = user
//            }
//        }
        self.user = UserHelpers.currentUser
    }
    
}

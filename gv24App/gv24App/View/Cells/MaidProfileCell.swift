//
//  MaidProfileCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/30/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

@objc protocol MaidProfileDelegate{
    func report()
    func choose()
}
class MaidProfileCell: UserProfileCell {
    
    var user: MaidProfile?{
        didSet{
            self.ratingView.point = user!.workInfo?.evaluationPoint as? Double
            self.labelAge.text = "\(user?.age ?? 0)"
            self.labelPhone.text = user?.phone
            self.labelAddress.text = user?.address?.name
            self.labelName.text = user?.name
            if user?.gender == 0{
                labelGender.text = LanguageManager.shared.localized(string: "Male")
            }else{
                labelGender.text = LanguageManager.shared.localized(string: "Female")
            }
            self.avatarImageView.loadImageUsingUrlString(urlString: (user?.avatarUrl)!)
        }
    }
    let labelAge : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let iconAge = IconView(icon: .androidCalendar, size: 15, color: AppColor.backButton)
    let ageLine = UIView.horizontalLine()
    let addressLine = UIView.horizontalLine()
    
    override func addSubview() {
        self.layer.masksToBounds = true
        super.addSubview()
        addSubview(labelAge)
        addSubview(iconAge)
        addSubview(ageLine)
        addSubview(addressLine)
    }
    
    override func setupIcon() {
        super.setupIcon()
        
        iconAge.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        iconAge.rightAnchor.constraint(equalTo: labelAge.leftAnchor, constant: -10).isActive = true
        iconAge.centerYAnchor.constraint(equalTo: labelAge.centerYAnchor, constant: 0).isActive = true
        
        ageLine.topAnchor.constraint(equalTo: labelAge.bottomAnchor, constant: 0).isActive = true
        ageLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        ageLine.leftAnchor.constraint(equalTo: labelAge.leftAnchor, constant: 0).isActive = true
        
        addressLine.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 0).isActive = true
        addressLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        addressLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
    }
    
    override func setupBottomView() {
        setupIcon()
        
        labelGender.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelGender.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelGender.topAnchor.constraint(equalTo: imageBackGround.bottomAnchor, constant: 0).isActive = true
        
        labelAge.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelAge.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelAge.topAnchor.constraint(equalTo: labelGender.bottomAnchor, constant: 0).isActive = true
        

        
        labelPhone.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelPhone.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelPhone.topAnchor.constraint(equalTo: labelAge.bottomAnchor, constant: 0).isActive = true
        
        labelAddress.heightAnchor.constraint(equalToConstant: 50).isActive = true
        labelAddress.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelAddress.topAnchor.constraint(equalTo: labelPhone.bottomAnchor, constant: 0).isActive = true
    }
    override func getUserInfo() {
        
    }

}

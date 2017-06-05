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

    var delegate : MaidProfileDelegate?
    var user: MaidProfile?{
        didSet{
//            self.ratingView.point = user!.workInfo?.evaluationPoint as! Double
//            self.labelPrice.text = "\(String(describing: (user?.workInfo?.price)!))"
//            self.labelPhone.text = user?.phone
//            self.labelAddress.text = user?.address?.name
//            self.labelName.text = user?.name
//            if user?.gender == 0{
//                labelGender.text = "Nam"
//            }else{
//                labelGender.text = "Nữ"
//            }
//            self.avatarImageView.loadImageurl(link: (user?.avatarUrl)!)
        }
    }

    let labelPrice : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let labelReport : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = AppColor.backButton
        lb.text = "Báo cáo người giúp việc"
        return lb
    }()
    let labelChoose : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = AppColor.backButton
        lb.text = "Chọn người giúp việc"
        return lb
    }()
    
    let buttonReport = UIButton(type: .custom)
    let buttonChoose = UIButton(type: .custom)
    
    let iconPrice = IconView(icon: .socialUsd, size: 15, color: AppColor.backButton)
    let iconCheck = IconView(icon: .checkmark, size: 15, color: AppColor.backButton)
    let priceLine = UIView.horizontalLine()
    let addressLine = UIView.horizontalLine()
    let reportLine = UIView.horizontalLine()
    
    override func addSubview() {
        super.addSubview()
        addSubview(labelPrice)
        addSubview(iconPrice)
        addSubview(priceLine)
        addSubview(labelReport)
        addSubview(labelChoose)
        addSubview(addressLine)
        addSubview(reportLine)
        addSubview(iconCheck)
        addSubview(buttonReport)
        addSubview(buttonChoose)
    }
    override func setupIcon() {
        super.setupIcon()
        
        iconPrice.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        iconPrice.rightAnchor.constraint(equalTo: labelPrice.leftAnchor, constant: -10).isActive = true
        iconPrice.centerYAnchor.constraint(equalTo: labelPrice.centerYAnchor, constant: 0).isActive = true
        
        priceLine.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: 0).isActive = true
        priceLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        priceLine.leftAnchor.constraint(equalTo: labelPrice.leftAnchor, constant: 0).isActive = true
        
        iconCheck.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        iconCheck.centerYAnchor.constraint(equalTo: labelChoose.centerYAnchor, constant: 0).isActive = true
        
        addressLine.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 0).isActive = true
        addressLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        addressLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        reportLine.topAnchor.constraint(equalTo: labelReport.bottomAnchor, constant: 0).isActive = true
        reportLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        reportLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
    
    override func setupBottomView() {
        setupIcon()
        
        labelPrice.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelPrice.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelPrice.topAnchor.constraint(equalTo: imageBackGround.bottomAnchor, constant: 0).isActive = true
        
        labelGender.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelGender.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelGender.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: 0).isActive = true
        
        labelPhone.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelPhone.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelPhone.topAnchor.constraint(equalTo: labelGender.bottomAnchor, constant: 0).isActive = true
        
        labelAddress.heightAnchor.constraint(equalToConstant: 50).isActive = true
        labelAddress.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelAddress.topAnchor.constraint(equalTo: labelPhone.bottomAnchor, constant: 0).isActive = true
        
        labelReport.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        labelReport.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelReport.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelReport.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 0).isActive = true
        
        labelChoose.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        labelChoose.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelChoose.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelChoose.topAnchor.constraint(equalTo: labelReport.bottomAnchor, constant: 0).isActive = true
        
        buttonReport.translatesAutoresizingMaskIntoConstraints = false
        buttonReport.topAnchor.constraint(equalTo: labelReport.topAnchor, constant: 0).isActive = true
        buttonReport.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        buttonReport.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        buttonReport.bottomAnchor.constraint(equalTo: labelReport.bottomAnchor, constant: 0).isActive = true
        
        buttonChoose.translatesAutoresizingMaskIntoConstraints = false
        buttonChoose.topAnchor.constraint(equalTo: labelChoose.topAnchor, constant: 0).isActive = true
        buttonChoose.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        buttonChoose.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        buttonChoose.bottomAnchor.constraint(equalTo: labelChoose.bottomAnchor, constant: 0).isActive = true
        
        buttonReport.addTarget(self, action: #selector(handleReportButton(_:)), for: .touchUpInside)
        buttonChoose.addTarget(self, action: #selector(handleChooseButton(_:)), for: .touchUpInside)
    }
    
    func handleChooseButton(_ sender: UIButton){
        if delegate != nil{
            self.delegate?.choose()
        }
    }
    func handleReportButton(_ sender: UIButton){
        if delegate != nil{
            self.delegate?.report()
        }
    }
    override func getUserInfo() {
        
    }

}

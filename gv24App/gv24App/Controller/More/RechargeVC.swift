//
//  RechargeVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/13/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class RechargeVC: BaseVC {
    
    var contact : Contact?{
        didSet{
            labelAddress.text = contact?.address
            labelHotLine.text = contact?.phone
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Hướng dẫn nạp tiền"
        MoreService.shared.getContact { (contact, error) in
            self.contact = contact
        }
        
    }

    let buttonRecharge : RechargeButton = {
        let btn = RechargeButton()
        btn.iconName = "thanhtoan-1"
        btn.title = "OnlinePayment"
        btn.addTarget(self, action: #selector(handleButtonRecharge(_:)), for: .touchUpInside)
        return btn
    }()
    let buttonTransferInfo : RechargeButton = {
        let btn = RechargeButton()
        btn.iconName = "thanhtoan-2"
        btn.title = "Thông tin chuyển khoản"
        btn.addTarget(self, action: #selector(handleButtonTransferInfo(_:)), for: .touchUpInside)
        return btn
    }()
    let contactView : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.white
        let topLine = UIView.horizontalLine()
        let bottomLine = UIView.horizontalLine()
        v.addSubview(topLine)
        v.addSubview(bottomLine)
        v.addConstraintWithFormat(format: "H:|[v0]|", views: topLine)
        v.addConstraintWithFormat(format: "H:|[v0]|", views: bottomLine)
        
        topLine.topAnchor.constraint(equalTo: v.topAnchor, constant: 0).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0).isActive = true
        return v
    }()
    let labelAddress: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .light, size: 13)
        lb.numberOfLines = 0
        lb.textAlignment = .justified
        return lb
    }()
    
    let labelHotLine : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .light, size: 13)
        return lb
    }()


    
    override func setupView() {
        super.setupView()
        view.backgroundColor = AppColor.collection
        view.addSubview(buttonRecharge)
        view.addSubview(buttonTransferInfo)
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LanguageManager.shared.localized(string: "Recharge")
        label.font = Fonts.by(name: .light, size: 15)
        label.textColor = UIColor.darkGray
        view.addSubview(label)
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        buttonRecharge.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        buttonRecharge.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        buttonRecharge.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        buttonRecharge.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        buttonTransferInfo.topAnchor.constraint(equalTo: buttonRecharge.bottomAnchor, constant: 20).isActive = true
        buttonTransferInfo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        buttonTransferInfo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        buttonTransferInfo.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        setupContactInfoView()
        setupLogoView()
    }
    
    
    func setupContactInfoView(){
        
        view.addSubview(contactView)
        contactView.topAnchor.constraint(equalTo: buttonTransferInfo.bottomAnchor, constant: 20).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: contactView)
        
        let labelContent = UILabel()
        labelContent.translatesAutoresizingMaskIntoConstraints = false
        labelContent.font = Fonts.by(name: .medium, size: 15)
        labelContent.text = "Ngoài ra, khách hàng có thể đến trụ sở công ty để gửi tiền trực tiếp vào tài khoản NGV24."
        labelContent.numberOfLines = 3
        labelContent.textAlignment = .justified
        
        let iconAddress = IconView(icon: .home, size: 20, color: AppColor.backButton)
        let iconCall = IconView(icon: .iosTelephone, size: 20, color: AppColor.backButton)
        
        contactView.addSubview(labelContent)
        contactView.addSubview(labelAddress)
        contactView.addSubview(labelHotLine)
        contactView.addSubview(iconAddress)
        contactView.addSubview(iconCall)
        
        contactView.addConstraintWithFormat(format: "V:|-10-[v0]-10-[v1]-10-[v2]-10-|", views: labelContent, labelAddress, labelHotLine)
        contactView.addConstraintWithFormat(format: "H:|-20-[v0]-15-|", views: labelContent)
        contactView.addConstraintWithFormat(format: "H:|-20-[v0]-15-[v1]-20-|", views: iconAddress, labelAddress)
        contactView.addConstraintWithFormat(format: "H:|-20-[v0]-20-[v1]-20-|", views: iconCall, labelHotLine)
        
        iconAddress.centerYAnchor.constraint(equalTo: labelAddress.centerYAnchor, constant: 0).isActive = true
        iconCall.centerYAnchor.constraint(equalTo: labelHotLine.centerYAnchor, constant: 0).isActive = true
    }
    
    func setupLogoView(){
        
        
        let labelSlogan = UILabel()
        let logoImage = UIImageView(image: UIImage(named: "logo2"))
        
        view.addSubview(labelSlogan)
        view.addSubview(logoImage)
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.contentMode = .center
        logoImage.topAnchor.constraint(equalTo: contactView.bottomAnchor, constant: 10).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        labelSlogan.text = "Niềm tin - Chất lượng"
        labelSlogan.translatesAutoresizingMaskIntoConstraints = false
        labelSlogan.font = Fonts.by(name: .regular, size: 15)
        labelSlogan.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        labelSlogan.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 5).isActive = true
    }
    func handleButtonRecharge(_ sender: UIButton){
        
    }
    func handleButtonTransferInfo(_ sender: UIButton){
        let transferInfoVC = TransferInfoVC()
        transferInfoVC.contact = self.contact
        push(viewController: transferInfoVC)
    }
}

class RechargeButton: BaseButton {
    
    var iconName: String?{
        didSet{
            self.iconView.image = UIImage(named: iconName!)
        }
    }
    var title: String?{
        didSet{
            titleView.text = LanguageManager.shared.localized(string: title!)
        }
    }
    private let iconView : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private let titleView : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .medium, size: 16)
        return lb
    }()
    
    override func setupView() {
        super.setupView()
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)
        addSubview(titleView)
        
        iconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        iconView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        iconView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .width, relatedBy: .equal, toItem: iconView, attribute: .height, multiplier: 1, constant: 0))
        
        titleView.leftAnchor.constraint(equalTo: iconView.rightAnchor, constant: 20).isActive = true
        titleView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        
        let topLine = UIView.horizontalLine()
        let bottomLine = UIView.horizontalLine()
        
        
        addSubview(topLine)
        addSubview(bottomLine)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: topLine)
        addConstraintWithFormat(format: "H:|[v0]|", views: bottomLine)
        
        topLine.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
    }
}

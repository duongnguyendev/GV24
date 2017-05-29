//
//  ContactVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/26/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import MessageUI

class ContactVC: BaseVC, MFMailComposeViewControllerDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Liên hệ"
    }

    private let logoView : IconView = {
        let lV = IconView(image: "logo2", size: 100)
        return lV
    }()
    private let labelCompanyName : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .medium, size: 15)
        lb.text = "Công ty TNHH GV24"
        return lb
    }()
    private let labelAddress : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .regular, size: 15)
        lb.textAlignment = .justified
        lb.text = "Địa chỉ:\n123 đường số 1, phường Phạm Ngũ Lão, Quận 1, Thành Phố Hồ Chí Minh"
        lb.numberOfLines = 0
        return lb
    }()
    private let buttonCall : BasicButton = {
        let btn = BasicButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.color = AppColor.backButton
        btn.addTarget(self, action: #selector(handleCall(_:)), for: .touchUpInside)
        btn.title = "Gọi điện"
        return btn
    }()
    private let buttonMail : BasicButton = {
        let btn = BasicButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.color = AppColor.homeButton1
        btn.addTarget(self, action: #selector(handleMail(_:)), for: .touchUpInside)
        btn.title = "Email"
        return btn
    }()
    private let companyNameLine = UIView.horizontalLine()
    private let addressLine = UIView.horizontalLine()
    
    
    override func setupView() {
        
        view.addSubview(logoView)
        view.addSubview(labelCompanyName)
        view.addSubview(companyNameLine)
//        view.addSubview(labelAddressTitle)
        view.addSubview(labelAddress)
        view.addSubview(addressLine)
        view.addSubview(buttonMail)
        view.addSubview(buttonCall)
        
        
        logoView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        logoView.topAnchor.constraint(equalTo: view.topAnchor, constant: margin).isActive = true
        
        labelCompanyName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true
        labelCompanyName.topAnchor.constraint(equalTo: logoView.bottomAnchor, constant: margin).isActive = true
        
        companyNameLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true
        companyNameLine.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin).isActive = true
        companyNameLine.topAnchor.constraint(equalTo: labelCompanyName.bottomAnchor, constant: 10).isActive = true
        
        labelAddress.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true
        labelAddress.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin).isActive = true
        labelAddress.topAnchor.constraint(equalTo: companyNameLine.bottomAnchor, constant: 10).isActive = true
        
        addressLine.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true
        addressLine.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin).isActive = true
        addressLine.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 10).isActive = true
        
        buttonCall.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true
        buttonCall.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonCall.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.frame.size.height / 3)).isActive = true
        buttonCall.rightAnchor.constraint(equalTo: buttonMail.leftAnchor, constant: -10).isActive = true
        
        buttonMail.centerYAnchor.constraint(equalTo: buttonCall.centerYAnchor, constant: 0).isActive = true
        buttonMail.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonMail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin).isActive = true
        
        view.addConstraint(NSLayoutConstraint(item: buttonCall, attribute: .width, relatedBy: .equal, toItem: buttonMail, attribute: .width, multiplier: 1, constant: 0))
        
        
    }
    
    func handleCall(_ sender : UIButton){
        
        if let url = URL(string: "tel://\(0906865192)") {
            UIApplication.shared.openURL(url)
        }
    }
    func handleMail(_ sender : UIButton){
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
        }else{
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            
            // Configure the fields of the interface.
            composeVC.setToRecipients(["address@example.com"])
            composeVC.setSubject("Hello!")
            composeVC.setMessageBody("Hello from California!", isHTML: false)
            
            // Present the view controller modally.
            self.present(composeVC, animated: true, completion: nil)
        }

    }
}
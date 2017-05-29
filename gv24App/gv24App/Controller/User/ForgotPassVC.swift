//
//  ForgotPassVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class ForgotPassVC: BaseVC {
    
    let itemSize : CGFloat = 50.0

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Quên mật khẩu"
    }
    
    private let textFieldUserName : UITextField = {
        let tf = UITextField()
        tf.font = Fonts.by(name: .light, size: 14)
        tf.placeholder = "Tên đăng nhập"
        return tf
    }()
    private let textFieldEmail : UITextField = {
        let tf = UITextField()
        tf.font = Fonts.by(name: .light, size: 14)
        tf.placeholder = "Email"
        return tf
    }()
    private let buttonSend : BasicButton = {
        let btn = BasicButton()
        btn.color = AppColor.homeButton3
        btn.title = "Gửi yêu cầu"
        btn.addTarget(self, action: #selector(handleSendButton(_:)), for: .touchUpInside)
        return btn
        
    }()
    
    
    
    override func setupView() {
        super.setupView()
        
        let iconUser = IconView(icon: .person, size: 15, color: AppColor.lightGray)
        let iconEmail = IconView(icon: .email, size: 15, color: AppColor.lightGray)
        
        let verticalLineUser = UIView.horizontalLine()
        let verticalLineEmail = UIView.horizontalLine()
        
        view.addSubview(iconEmail)
        view.addSubview(iconUser)
        
        view.addSubview(verticalLineUser)
        view.addSubview(verticalLineEmail)
        
        view.addSubview(textFieldUserName)
        view.addSubview(textFieldEmail)
        view.addSubview(buttonSend)
        
        view.addConstraintWithFormat(format: "V:|-20-[v0][v1]-40-[v2]", views: textFieldUserName, textFieldEmail, buttonSend)
        
        textFieldUserName.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        textFieldEmail.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        buttonSend.heightAnchor.constraint(equalToConstant: itemSize - 10).isActive = true
        
        
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-5-[v1]-\(margin)-|", views: iconUser, textFieldUserName)
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-5-[v1]-\(margin)-|", views: iconEmail, textFieldEmail)
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: buttonSend)
        
        iconEmail.centerYAnchor.constraint(equalTo: textFieldEmail.centerYAnchor, constant: 0).isActive = true
        iconUser.centerYAnchor.constraint(equalTo: textFieldUserName.centerYAnchor, constant: 0).isActive = true
        
        verticalLineUser.topAnchor.constraint(equalTo: textFieldUserName.bottomAnchor, constant: 0).isActive = true
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: verticalLineUser)
        
        verticalLineEmail.topAnchor.constraint(equalTo: textFieldEmail.bottomAnchor, constant: 0).isActive = true
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: verticalLineEmail)
    }
    
    func handleSendButton(_ sender : UIButton){
    
    }
}
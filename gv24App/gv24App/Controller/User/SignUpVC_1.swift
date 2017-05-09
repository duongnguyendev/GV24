//
//  SingUpVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class SignUpVC_1: BaseVC {
    
    let itemSize : CGFloat = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTouchUpOutSize = true
        title = "Đăng ký"
    }
    
    private let textFieldUserName : UITextField = {
        let tf = UITextField()
        tf.font = Fonts.by(name: .light, size: 14)
        tf.placeholder = "Tên đăng nhập"
        return tf
    }()
    
    private let textFieldPass : UITextField = {
        let tf = UITextField()
        tf.font = Fonts.by(name: .light, size: 14)
        tf.placeholder = "Mật khẩu"
        return tf
    }()
    private let textFieldConfirmPass : UITextField = {
        let tf = UITextField()
        tf.font = Fonts.by(name: .light, size: 14)
        tf.placeholder = "Xác nhận mật khẩu"
        return tf
    }()
    
    private let buttonNext : BasicButton = {
        let btn = BasicButton()
        btn.color = AppColor.homeButton3
        btn.title = "Next"
        btn.addTarget(self, action: #selector(handleNextButton(_:)), for: .touchUpInside)
        return btn
        
    }()
    
    
    override func setupView() {
        super.setupView()
        
        view.addSubview(textFieldUserName)
        view.addSubview(textFieldPass)
        view.addSubview(textFieldConfirmPass)
        view.addSubview(buttonNext)
        
        let userNameLine = UIView.horizontalLine()
        let passLine = UIView.horizontalLine()
        let confirmPassLine = UIView.horizontalLine()
        
        let iconUser = IconView(icon: .person, size: 15, color: AppColor.lightGray)
        let iconPass = IconView(icon: .locked, size: 15, color: AppColor.lightGray)
        let iconConfirmPass = IconView(icon: .locked, size: 15, color: AppColor.lightGray)
        
        view.addSubview(userNameLine)
        view.addSubview(passLine)
        view.addSubview(confirmPassLine)
        view.addSubview(iconUser)
        view.addSubview(iconPass)
        view.addSubview(iconConfirmPass)
        
        view.addConstraintWithFormat(format: "V:|-20-[v0][v1][v2]-\(margin)-[v3]", views: textFieldUserName, textFieldPass, textFieldConfirmPass, buttonNext)
        
        textFieldUserName.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        textFieldPass.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        textFieldConfirmPass.heightAnchor.constraint(equalToConstant: itemSize).isActive = true
        buttonNext.heightAnchor.constraint(equalToConstant: itemSize - 10).isActive = true
        
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-5-[v1]-\(margin)-|", views: iconUser, textFieldUserName)
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-5-[v1]-\(margin)-|", views: iconPass, textFieldPass)
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-5-[v1]-\(margin)-|", views: iconConfirmPass, textFieldConfirmPass)
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: buttonNext)
        
        iconUser.centerYAnchor.constraint(equalTo: textFieldUserName.centerYAnchor, constant: 0).isActive = true
        iconPass.centerYAnchor.constraint(equalTo: textFieldPass.centerYAnchor, constant: 0).isActive = true
        iconConfirmPass.centerYAnchor.constraint(equalTo: textFieldConfirmPass.centerYAnchor, constant: 0).isActive = true
        
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: userNameLine)
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: passLine)
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: confirmPassLine)
        
        userNameLine.topAnchor.constraint(equalTo: textFieldUserName.bottomAnchor, constant: 0).isActive = true
        passLine.topAnchor.constraint(equalTo: textFieldPass.bottomAnchor, constant: 0).isActive = true
        confirmPassLine.topAnchor.constraint(equalTo: textFieldConfirmPass.bottomAnchor, constant: 0).isActive = true
        
    }
    
    
    
    func handleNextButton(_ sender: UIButton){
        push(viewController: SignUpVC_2())
    }
}



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
        
        title = LanguageManager.shared.localized(string: "ForgotPassword")
    }
    
    private let textFieldUserName : UITextField = {
        let tf = UITextField()
        tf.font = Fonts.by(name: .light, size: 14)
        tf.placeholder = LanguageManager.shared.localized(string: "Username")
        return tf
    }()
    private let textFieldEmail : UITextField = {
        let tf = UITextField()
        tf.font = Fonts.by(name: .light, size: 14)
        tf.placeholder = LanguageManager.shared.localized(string: "EmailAddress")
        return tf
    }()
    private let buttonSend : BasicButton = {
        let btn = BasicButton()
        btn.color = AppColor.homeButton3
        btn.title = LanguageManager.shared.localized(string: "Request")
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
        
        if let validateString = validate(){
            showAlert(title: nil, message: validateString, completion: {
            })
        }else{
            requestForgotPassword()
        }
    }
    func requestForgotPassword(){
        activity.startAnimating()
        UserService.shared.forgotPassword(userName: textFieldUserName.text!, email: textFieldEmail.text!, completion: { (error) in
            self.activity.stopAnimating()
            if error != nil{
                self.showAlert(title: nil, message: error, completion: {
                    
                })
            }else{
                self.showAlert(title: nil, message: "APasswordResetLinkIsSentToYourEmail", completion: {
                    self.goBack()
                })
            }
        })
    }
    func showAlert(title : String?, message : String?, completion: @escaping (()->())){
        var mTitle = title
        var mMessage = message
        if title != nil {
            mTitle = LanguageManager.shared.localized(string: title!)
        }
        if message != nil{
            mMessage = LanguageManager.shared.localized(string: message!)
        }
        
        let alert = UIAlertController(title: mTitle, message: mMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (nil) in
            completion()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    func validate()-> String?{
        if (textFieldUserName.text?.trimmingCharacters(in: .whitespaces).characters.count)! < 6{
            return LanguageManager.shared.localized(string: "InvalidUsername")
        }
        if !(textFieldEmail.text?.isEmail)! {
            return LanguageManager.shared.localized(string: "InvalidEmailAddress")
        }
        return nil
    }
}

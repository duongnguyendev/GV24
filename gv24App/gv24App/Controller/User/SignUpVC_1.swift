//
//  SingUpVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class SignUpVC_1: BaseVC {
    
    weak var delegate : UserEventDelegate?
    let itemSize : CGFloat = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTouchUpOutSize = true
        title = LanguageManager.shared.localized(string: "SingUp")
    }
    
    private let textFieldUserName : UITextField = {
        let tf = UITextField()
        tf.font = Fonts.by(name: .light, size: 14)
        tf.placeholder = LanguageManager.shared.localized(string: "Username")
        return tf
    }()
    
    private let textFieldPass : UITextField = {
        let tf = UITextField()
        tf.font = Fonts.by(name: .light, size: 14)
        tf.placeholder = LanguageManager.shared.localized(string: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    private let textFieldConfirmPass : UITextField = {
        let tf = UITextField()
        tf.font = Fonts.by(name: .light, size: 14)
        tf.placeholder = LanguageManager.shared.localized(string: "ConfirmPassword")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let buttonNext : BasicButton = {
        let btn = BasicButton()
        btn.color = AppColor.homeButton3
        btn.title = LanguageManager.shared.localized(string: "Next")
        btn.addTarget(self, action: #selector(handleNextButton(_:)), for: .touchUpInside)
        return btn
        
    }()
    
    
    override func setupView() {
        super.setupView()
        
        view.addSubview(textFieldUserName)
        view.addSubview(textFieldPass)
        view.addSubview(textFieldConfirmPass)
        view.addSubview(buttonNext)
        UIButton.cornerButton(bt: buttonNext)
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
        //        self.push(viewController: SignUpVC_2())
        
        let username = textFieldUserName.text!
        let passWord = textFieldPass.text!
        
        if let validateError = validate(){
            showAlertWith(title: nil, message: validateError)
        }else{
            loadingView.show()
            UserService.shared.checkUsername(username: username) { (error) in
                self.loadingView.close()
                if error != nil{
                    self.showAlertWith(title: nil, message: LanguageManager.shared.localized(string: "DUPLICATED_USERNAME")!)
                }else{
                    let registerInfo : Dictionary<String, String> = ["username":username, "password": passWord]
                    let signUpVC_2 = SignUpVC_2()
                    signUpVC_2.delegate = self.delegate
                    signUpVC_2.userInfo = registerInfo
                    self.push(viewController: signUpVC_2)
                }
            }
        }
        
        
        
    }
    
    func validate() -> String?{
        if (textFieldUserName.text?.characters.count)! < 6 {
            return LanguageManager.shared.localized(string: "InvalidUsername")
        }else{
            return confirmPass()
        }
    }
    func confirmPass() -> String?{
        
        if (textFieldPass.text?.characters.count)! < 6 {
            return LanguageManager.shared.localized(string: "YourPasswordIsTooShort")
        }else{
            if textFieldConfirmPass.text != textFieldPass.text{
                return LanguageManager.shared.localized(string: "InvalidConfirmPassword")
            }
        }
        return nil
    }
    
    private func showAlertWith(title: String?, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
}



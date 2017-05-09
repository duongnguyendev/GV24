//
//  SignInVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/3/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import IoniconsSwift
import FacebookCore
import FacebookLogin

class SignInVC: BaseVC {
    
    private var itemHeight : CGFloat = 0
    
    override func viewDidLoad() {
        itemHeight = self.view.frame.size.height / 15
        super.viewDidLoad()
        hideKeyboardWhenTouchUpOutSize = true
        title = LanguageManager.shared.localized(string: "SignIn")
    }
    private let topBackGround : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "top_bg"))
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor.brown
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private let emailTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.font = Fonts.by(name: .light, size: 14)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    private let passTextField : UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        tf.font = Fonts.by(name: .light, size: 14)
        tf.placeholder = LanguageManager.shared.localized(string: "Password")
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let workAroundButton : BasicButton = {
        let btn = BasicButton()
        btn.color = AppColor.homeButton1
        btn.title = "Around"
        btn.addTarget(self, action: #selector(handleWordAroundButton(_:)), for: .touchUpInside)
        return btn
    }()
    private let signInButton : BasicButton = {
        let btn = BasicButton()
        btn.color = AppColor.homeButton3
        btn.title = "SignIn"
        btn.addTarget(self, action: #selector(handleSignInButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private let signUpButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Đăng ký ngay", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = Fonts.by(name: .regular, size: 14)
        btn.setTitleColor(AppColor.homeButton3, for: .normal)
        btn.addTarget(self, action: #selector(handleSignUpButton(_:)), for: .touchUpInside)
        return btn
    }()
    private let forgotPassButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Quên mật khẩu", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = Fonts.by(name: .regular, size: 14)
        btn.setTitleColor(AppColor.homeButton3, for: .normal)
        btn.addTarget(self, action: #selector(handleForgotPassButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private let facebookButton : UIButton = {
        let btn = UIButton()
        btn.setImage(Icon.by(name: .socialFacebook, color : AppColor.white), for: .normal )
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = AppColor.facebook
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btn.addTarget(self, action: #selector(handleFaceBookButton(_:)), for: .touchUpInside)
        return btn
    }()
    private let googleButton : UIButton = {
        let btn = UIButton()
        btn.setImage(Icon.by(name: .socialGoogle, color : AppColor.white), for: .normal )
        btn.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = AppColor.google
        btn.addTarget(self, action: #selector(handleGoogleButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - SetupView
    override func setupView() {
        super.setupView()
        self.setupTopView()
        self.setupBottomView()
    }
    private func setupTopView(){
        view.addSubview(topBackGround)
        view.addSubview(workAroundButton)
        
        let imageHeight = (self.view.bounds.size.height) / 8 * 3 - 20
        view.addConstraintWithFormat(format: "V:|[v0(\(imageHeight))]", views: topBackGround)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: topBackGround)
        
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: workAroundButton)
        workAroundButton.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        workAroundButton.bottomAnchor.constraint(equalTo: topBackGround.bottomAnchor, constant: -margin).isActive = true
        
        let logoView = IconView(image: "logo2", size: imageHeight / 3)
        view.addSubview(logoView)
        logoView.centerXAnchor.constraint(equalTo: topBackGround.centerXAnchor, constant: 0).isActive = true
        logoView.centerYAnchor.constraint(equalTo: topBackGround.centerYAnchor, constant: -30).isActive = true
    }
    
    private func setupBottomView(){
        setupInputView()
        setupSignInButton()
        setupSignUp_ForgotPass()
        setupSocialView()
    }
    
    private func setupInputView(){
        let line1 = UIView.horizontalLine()
        let line2 = UIView.horizontalLine()
        
        let iconUser = IconView(icon: .person, size: 15, color: AppColor.lightGray)
        let iconPass = IconView(icon: .locked, size: 15, color: AppColor.lightGray)
        view.addSubview(emailTextField)
        view.addSubview(passTextField)
        view.addSubview(iconUser)
        view.addSubview(iconPass)
        view.addSubview(line1)
        view.addSubview(line2)
        
        emailTextField.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        passTextField.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: topBackGround.bottomAnchor, constant: 20).isActive = true
        view.addConstraintWithFormat(format: "V:[v0][v1][v2][v3]", views: emailTextField, line1, passTextField, line2)
        
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: line1)
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: line2)
        
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-5-[v1]-\(margin)-|", views: iconUser, emailTextField)
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-5-[v1]-\(margin)-|", views: iconPass, passTextField)
        
        iconUser.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor, constant: 0).isActive = true
        iconPass.centerYAnchor.constraint(equalTo: passTextField.centerYAnchor, constant: 0).isActive = true
    }
    
    private func setupSignInButton(){
        view.addSubview(signInButton)
        
        signInButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 30).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: signInButton)
    }
    private func setupSignUp_ForgotPass(){
        
        let lineView = UIView.verticalLine()
        view.addSubview(lineView)
        lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        view.addSubview(signUpButton)
        view.addSubview(forgotPassButton)
        
        forgotPassButton.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        forgotPassButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 5).isActive = true
        forgotPassButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true
        forgotPassButton.rightAnchor.constraint(equalTo: lineView.leftAnchor, constant: 0).isActive = true
        
        signUpButton.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 5).isActive = true
        signUpButton.leftAnchor.constraint(equalTo: lineView.rightAnchor, constant: 0).isActive = true
        signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin).isActive = true
        
        lineView.centerYAnchor.constraint(equalTo: signUpButton.centerYAnchor, constant: 0).isActive = true
    }
    private func setupSocialView(){
        
        let socialView = UIView()
        socialView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(socialView)
        socialView.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 0).isActive = true
        socialView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: socialView)
        
        // label
        
        let lableSocial = UILabel()
        lableSocial.text = "Đăng nhập bằng"
        lableSocial.font = Fonts.by(name: .regular, size: 12)
        lableSocial.textColor = AppColor.lightGray
        lableSocial.textAlignment = .center
        lableSocial.translatesAutoresizingMaskIntoConstraints = false
        
        socialView.addSubview(lableSocial)
        socialView.addSubview(facebookButton)
        socialView.addSubview(googleButton)
        
        lableSocial.leftAnchor.constraint(equalTo: socialView.leftAnchor, constant: 0).isActive = true
        lableSocial.rightAnchor.constraint(equalTo: socialView.centerXAnchor, constant: 0).isActive = true
        lableSocial.centerYAnchor.constraint(equalTo: socialView.centerYAnchor, constant: 0).isActive = true
        
        facebookButton.centerYAnchor.constraint(equalTo: socialView.centerYAnchor, constant: 0).isActive = true
        facebookButton.widthAnchor.constraint(equalToConstant: itemHeight - 10).isActive = true
        facebookButton.heightAnchor.constraint(equalToConstant: itemHeight - 10).isActive = true
        facebookButton.leftAnchor.constraint(equalTo: socialView.centerXAnchor, constant: 0).isActive = true
        
        googleButton.centerYAnchor.constraint(equalTo: socialView.centerYAnchor, constant: 0).isActive = true
        googleButton.widthAnchor.constraint(equalToConstant: itemHeight - 10).isActive = true
        googleButton.heightAnchor.constraint(equalToConstant: itemHeight - 10).isActive = true
        googleButton.leftAnchor.constraint(equalTo: facebookButton.rightAnchor, constant: itemHeight - 20).isActive = true
        
        facebookButton.layer.cornerRadius = (itemHeight - 10) / 2
        facebookButton.layer.masksToBounds = true
        
        googleButton.layer.cornerRadius = (itemHeight - 10) / 2
        googleButton.layer.masksToBounds = true
        
    }
    //MARK: - Handle action
    
    func handleWordAroundButton(_ sender : UIButton) {
        push(viewController: MaidAroundVC())
    }
    func handleSignInButton(_ sender : UIButton) {
        print("handleSignInButton")
    }
    func handleSignUpButton(_ sender : UIButton) {
        push(viewController: SignUpVC_1())
    }
    func handleForgotPassButton(_ sender : UIButton) {
        push(viewController: ForgotPassVC())
    }
    func handleFaceBookButton(_ sender : UIButton) {
        
//        let loginManager = LoginManager()
//        loginManager.logIn([.publicProfile], viewController: self) { (loginResult) in
//            switch loginResult {
//            case .failed(let error):
//                print(error)
//            case .cancelled:
//                print("User cancelled login.")
//            case .success( _, _, let accessToken):
//                print("Logged in! \(accessToken)")
//            }
//        }
    }
    func handleGoogleButton(_ sender : UIButton) {
        
        
    }
}


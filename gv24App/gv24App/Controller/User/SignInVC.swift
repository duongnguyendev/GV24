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
import GoogleSignIn
import SwiftyJSON
import Firebase


@objc protocol UserEventDelegate{
    @objc optional func logedIn()
    @objc optional func signUpComplete()
}

let DATA_NOT_EXIST = "DATA_NOT_EXIST"
let INVALID_PASSWORD = "INVALID_PASSWORD "
class SignInVC: BaseVC, UserEventDelegate, GIDSignInUIDelegate, GIDSignInDelegate {
    
    private var itemHeight : CGFloat = 0
    override func viewDidLoad() {
        itemHeight = self.view.frame.size.height / 15
        super.viewDidLoad()
        hideKeyboardWhenTouchUpOutSize = true
        title = LanguageManager.shared.localized(string: "Login")
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    private let topBackGround : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "top_bg"))
        iv.contentMode = .scaleToFill
        iv.backgroundColor = UIColor.brown
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private let emailTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = LanguageManager.shared.localized(string: "Username")
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
        btn.title = "NearbyMaid"
        btn.addTarget(self, action: #selector(handleWordAroundButton(_:)), for: .touchUpInside)
        return btn
    }()
    private let signInButton : BasicButton = {
        let btn = BasicButton()
        btn.color = AppColor.homeButton3
        btn.title = "Login"
        btn.addTarget(self, action: #selector(handleSignInButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private let signUpButton : UIButton = {
        let btn = UIButton()
        let title = LanguageManager.shared.localized(string: "SignUpNow")
        btn.setTitle(title, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = Fonts.by(name: .regular, size: 14)
        btn.setTitleColor(AppColor.homeButton3, for: .normal)
        btn.addTarget(self, action: #selector(handleSignUpButton(_:)), for: .touchUpInside)
        return btn
    }()
    private let forgotPassButton : UIButton = {
        let btn = UIButton()
        let title = LanguageManager.shared.localized(string: "ForgotPassword")
        btn.setTitle(title, for: .normal)
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
        
        emailTextField.topAnchor.constraint(equalTo: topBackGround.bottomAnchor, constant: 0).isActive = true
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
        lableSocial.text = LanguageManager.shared.localized(string: "LoginWith")
        lableSocial.font = Fonts.by(name: .regular, size: 14)
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
        self.hideKeyboard()
        self.loadingView.show()
        if (self.emailTextField.text?.trimmingCharacters(in: .whitespaces).characters.count)! > 5 && (self.passTextField.text?.trimmingCharacters(in: .whitespaces).characters.count)! > 5 {
            UserService.shared.logIn(userName: emailTextField.text!, password: passTextField.text!, completion: { (userLogedIn, token, error) in
                self.loadingView.close()
                if error == nil{
                    UserHelpers.save(user: userLogedIn!, token: token!)
                    self.presentHome()
                }
                else{
                    self.showAlertWith(title: nil, mes: error)
                }
            })
        }else{
            self.loadingView.close()
            showAlertWith(title: nil, mes: "InvalidUsernamePassword")
        }
    }
    
    func showAlertWith(title: String?, mes: String?){
        var message = mes
        var mTitle = title
        if mes != nil {
            message = LanguageManager.shared.localized(string: mes!)
        }
        if title != nil {
            mTitle = LanguageManager.shared.localized(string: mes!)
        }
        if mes == DATA_NOT_EXIST{
            message = LanguageManager.shared.localized(string: "UserNotExist")
        }
        if mes == INVALID_PASSWORD{
            message = LanguageManager.shared.localized(string: "INVALID_PASSWORD")
        }
        let alert = UIAlertController(title: mTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleSignUpButton(_ sender : UIButton) {
        let signUpVC_1 = SignUpVC_1()
        signUpVC_1.delegate = self
        present(viewController: signUpVC_1)
    }
    func handleForgotPassButton(_ sender : UIButton) {
        present(viewController: ForgotPassVC())
    }
    func handleFaceBookButton(_ sender : UIButton) {
        let loginManager = LoginManager()
        loginManager.logIn([.publicProfile, .email], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                
                print("User cancelled login.")
                
            case .success( _, _, _):
                self.handleFacebookAccount()
            }
        }
    }
    func handleGoogleButton(_ sender : UIButton) {
        GIDSignIn.sharedInstance().signIn()
        
    }
    
    func signUpComplete() {
        presentHome()
    }
    
    func presentHome() {
        self.dismiss(animated: true, completion: nil)
    }
    func handleFacebookAccount(){
        self.loadingView.show()
        GraphRequest(graphPath: "me", parameters: ["field" : "id, name, email, phone"], accessToken: AccessToken.current, httpMethod: .GET).start { (response, result) in
            switch result{
            case .failed(let error):
                print(error)
            case .success(response: let res):
                var userInfo = Dictionary<String, String>()
                let id = res.dictionaryValue?["id"] as? String
                userInfo["id"] = id
                userInfo["username"] = "fb" + id!
                userInfo["name"] = res.dictionaryValue?["name"] as? String
                userInfo["email"] = res.dictionaryValue?["email"] as? String
                userInfo["token"] = AccessToken.current?.authenticationToken
                userInfo["image"] = "http://graph.facebook.com/\(((AccessToken.current?.userId)!))/picture?type=large"
                self.loginSocial(userInfo: userInfo)
            }
        }
    }
    
    func loginSocial(userInfo : Dictionary<String, String>){
        self.loadingView.show()
        UserService.shared.loginSocial(userInfo: userInfo) { (user, token, error) in
            self.loadingView.close()
            if error != nil{
                if error == DATA_NOT_EXIST{
                    self.handleSignUpSocical(userInfo: userInfo)
                }else{
                    print(error!)
                }
            }else{
                UserHelpers.save(user: user!, token: token!)
                self.presentHome()
            }
        }
    }
    
    func handleSignUpSocical(userInfo: Dictionary<String, String>){
        let signUpSocialVC = SignUpSocialVC()
        signUpSocialVC.userInfo = userInfo
        signUpSocialVC.delegate = self
        present(viewController: signUpSocialVC)
    }
    //MARK: -Google sign in delegate
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        self.loadingView.close()
        self.dismiss(animated: true, completion: nil)
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
        
        }else{
            var userInfo = Dictionary<String, String>()
            userInfo["id"] = user.userID
            userInfo["username"] = "gm" + user.userID
            userInfo["name"] = user.profile.name
            userInfo["email"] = user.profile.email
            userInfo["token"] = user.authentication.accessToken
            userInfo["image"] = user.profile.imageURL(withDimension: UInt.allZeros).absoluteString
            loginSocial(userInfo: userInfo)
        }
        
    }
}



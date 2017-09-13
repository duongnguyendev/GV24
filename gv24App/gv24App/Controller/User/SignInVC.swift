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

@objc protocol UserEventDelegate {
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
        title = LanguageManager.shared.localized(string: "SignIn")
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hiddenNav = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        hiddenNav = true
    }
    
    private let topBackGround : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    private let backgroundView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "bg_app"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isUserInteractionEnabled = true
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    
    private let emailTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = LanguageManager.shared.localized(string: "Username")
        tf.font = Fonts.by(name: .regular, size: 13)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    
    private let passTextField : UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = true
        tf.font = Fonts.by(name: .regular, size: 13)
        tf.placeholder = LanguageManager.shared.localized(string: "Password")
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    private let workAroundButton : BasicButton = {
        let btn = BasicButton()
        btn.color = AppColor.homeButton1
        btn.title = "TitleNearbyWorkers"
        btn.cornerRadius = 8
        btn.addTarget(self, action: #selector(handleWordAroundButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    private let signInButton : BasicButton = {
        let btn = BasicButton()
        btn.color = AppColor.homeButton3
        btn.cornerRadius = 8
        btn.title = "SignInUppercase"
        btn.addTarget(self, action: #selector(handleSignInButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private let signUpButton : UIButton = {
        let btn = UIButton()
        let title = LanguageManager.shared.localized(string: "SingUp")
        btn.setTitle(title, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = Fonts.by(name: .regular, size: 13)
        btn.setTitleColor(AppColor.homeButton3, for: .normal)
        btn.addTarget(self, action: #selector(handleSignUpButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    private let forgotPassButton : UIButton = {
        let btn = UIButton()
        let title = LanguageManager.shared.localized(string: "ForgotPassword")
        btn.setTitle(title, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.titleLabel?.font = Fonts.by(name: .regular, size: 13)
        btn.setTitleColor(AppColor.homeButton3, for: .normal)
        btn.addTarget(self, action: #selector(handleForgotPassButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    
    private let facebookButton : ButtonWithIcon = {
        let btn = ButtonWithIcon()
        btn.iconName = Icon.by(name: .socialFacebook, size: 30, collor: AppColor.white)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = AppColor.facebook
        btn.title = "Facebook"
        btn.addTarget(self, action: #selector(handleFaceBookButton(_:)), for: .touchUpInside)
        return btn
    }()
    private let googleButton : ButtonWithIcon = {
        let btn = ButtonWithIcon()
        btn.iconName = Icon.by(name: .socialGoogle, size: 30, collor: AppColor.white)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = AppColor.google
        btn.title = "Google"
        btn.addTarget(self, action: #selector(handleGoogleButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    private let mainView : UIView = {
        let iv = UIView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 12
        iv.backgroundColor = UIColor.rgbAlpha(red: 255, green: 255, blue: 255, alpha: 0.8)
        return iv
    }()
    
    private let copyRightLabel: UILabel = {
       let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .light, size: 14)
        lb.textAlignment = .center
        lb.textColor = .black
        lb.text = "Copyright © 2017. HBB Solutions"
        return lb
    }()
    
    //MARK: - SetupView
    let mMargin : CGFloat = UIScreen.main.bounds.size.width / 10
    override func setupView() {
        super.setupView()
        setupMainView()
        setupTopView()
        setupBottomView()
        setupCopyRightView()

    }
    
    private func setupMainView(){
        view.addSubview(backgroundView)
        backgroundView.addSubview(mainView)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: backgroundView)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: backgroundView)
        
        backgroundView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: mainView)
        backgroundView.addConstraintWithFormat(format: "V:|-30-[v0(\(view.frame.size.height * 2/3))]", views: mainView)
    }
    
    private func setupTopView(){
        mainView.addSubview(topBackGround)
        mainView.addSubview(workAroundButton)
        
        let imageHeight = (self.view.bounds.size.height) / 8 * 3 - 20
        mainView.addConstraintWithFormat(format: "V:|[v0(\(imageHeight))]", views: topBackGround)
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: topBackGround)
        
        mainView.addConstraintWithFormat(format: "H:|-\(mMargin)-[v0]-\(mMargin)-|", views: workAroundButton)
        workAroundButton.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        workAroundButton.bottomAnchor.constraint(equalTo: topBackGround.bottomAnchor, constant: -mMargin/2).isActive = true
        
        let logoView = UIImageView(image: UIImage(named: "logo2"))
        logoView.translatesAutoresizingMaskIntoConstraints = false
        logoView.contentMode = .scaleAspectFit
        mainView.addSubview(logoView)
        logoView.centerXAnchor.constraint(equalTo: topBackGround.centerXAnchor, constant: 0).isActive = true
        logoView.topAnchor.constraint(equalTo: topBackGround.topAnchor, constant: mMargin).isActive = true
        logoView.bottomAnchor.constraint(equalTo: workAroundButton.topAnchor, constant: -20).isActive = true
        
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
        
        let iconUser = IconView(icon: .person, size: 15, color: UIColor.darkGray)
        let iconPass = IconView(icon: .locked, size: 15, color: UIColor.darkGray)
        mainView.addSubview(emailTextField)
        mainView.addSubview(passTextField)
        mainView.addSubview(iconUser)
        mainView.addSubview(iconPass)
        mainView.addSubview(line1)
        mainView.addSubview(line2)
        
        emailTextField.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        passTextField.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: topBackGround.bottomAnchor, constant: 0).isActive = true
        mainView.addConstraintWithFormat(format: "V:[v0][v1][v2][v3]", views: emailTextField, line1, passTextField, line2)
        
        mainView.addConstraintWithFormat(format: "H:|-\(mMargin)-[v0]-\(mMargin)-|", views: line1)
        mainView.addConstraintWithFormat(format: "H:|-\(mMargin)-[v0]-\(mMargin)-|", views: line2)
        
        mainView.addConstraintWithFormat(format: "H:|-\(mMargin)-[v0]-5-[v1]-\(mMargin)-|", views: iconUser, emailTextField)
        mainView.addConstraintWithFormat(format: "H:|-\(mMargin)-[v0]-5-[v1]-\(mMargin)-|", views: iconPass, passTextField)
        
        iconUser.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor, constant: 0).isActive = true
        iconPass.centerYAnchor.constraint(equalTo: passTextField.centerYAnchor, constant: 0).isActive = true
    }
    
    private func setupSignInButton(){
        mainView.addSubview(signInButton)
        
        signInButton.topAnchor.constraint(equalTo: passTextField.bottomAnchor, constant: 30).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        mainView.addConstraintWithFormat(format: "H:|-\(mMargin)-[v0]-\(mMargin)-|", views: signInButton)
    }
    private func setupSignUp_ForgotPass(){
        
        let lineView = UIView.verticalLine()
        mainView.addSubview(lineView) 
        lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        mainView.addSubview(signUpButton)
        mainView.addSubview(forgotPassButton)
        
        forgotPassButton.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        forgotPassButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 5).isActive = true
        forgotPassButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: mMargin).isActive = true
        forgotPassButton.rightAnchor.constraint(equalTo: lineView.leftAnchor, constant: 0).isActive = true
        
        signUpButton.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 5).isActive = true
        signUpButton.leftAnchor.constraint(equalTo: lineView.rightAnchor, constant: 0).isActive = true
        signUpButton.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -mMargin).isActive = true
        
        lineView.centerYAnchor.constraint(equalTo: signUpButton.centerYAnchor, constant: 0).isActive = true
    }
    private func setupSocialView(){
    
        let socialView = UIView()
        socialView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(socialView)
        
        backgroundView.addConstraintWithFormat(format: "H:|-\(mMargin)-[v0]-\(mMargin)-|", views: socialView)
        socialView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true
        socialView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        
        // label
        let lableSocial = UILabel()
        lableSocial.text = LanguageManager.shared.localized(string: "LoginWith")
        lableSocial.font = Fonts.by(name: .regular, size: 14)
        lableSocial.textColor = .black
        lableSocial.textAlignment = .center
        lableSocial.translatesAutoresizingMaskIntoConstraints = false
        
        socialView.addSubview(lableSocial)
        socialView.addSubview(facebookButton)
        socialView.addSubview(googleButton)
        
        lableSocial.centerXAnchor.constraint(equalTo: socialView.centerXAnchor, constant: 0).isActive = true
        lableSocial.topAnchor.constraint(equalTo: socialView.topAnchor, constant: 10).isActive = true
        
        socialView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: facebookButton)
        facebookButton.topAnchor.constraint(equalTo: lableSocial.bottomAnchor, constant: 16).isActive = true
        facebookButton.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        
        socialView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: googleButton)
        googleButton.topAnchor.constraint(equalTo: facebookButton.bottomAnchor, constant: 8).isActive = true
        googleButton.heightAnchor.constraint(equalToConstant: itemHeight).isActive = true
        
        facebookButton.layer.cornerRadius = 8
        googleButton.layer.cornerRadius = 8
    }
    
    func setupCopyRightView() {
        backgroundView.addSubview(copyRightLabel)
        
        backgroundView.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: copyRightLabel)
        copyRightLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
    }
    
    //MARK: - Handle action
    
    func handleWordAroundButton(_ sender : UIButton) {
        push(viewController: MaidAroundVC())
    }
    func handleSignInButton(_ sender : UIButton) {
        self.hideKeyboard()
        self.loadingView.show()
        if let validateError = validate(){
            self.loadingView.close()
            showAlertWith(title: nil, mes: validateError)
        }else{
            UserService.shared.logIn(userName: emailTextField.text!, password: passTextField.text!, completion: { (userLogedIn, token, error) in
                self.loadingView.close()
                if error == nil{
                    UserHelpers.save(user: userLogedIn!, newToken: token!)
                    self.presentHome()
                }
                else{
                    self.showAlertWith(title: nil, mes: error)
                }
            })
        }
    }
    
    func validate()->String?{
        let emailError = validateEmail()
        let passError = validatePass()
        
        if emailError == "PleaseCompleteAllInformation" || passError == "PleaseCompleteAllInformation"{
            return "PleaseCompleteAllInformation"
        }
        
        if emailError != nil{
            return emailError
        }
        
        return passError
    }
    func validateEmail()->String?{
        if (self.emailTextField.text?.trimmingCharacters(in: .whitespaces).characters.count)! == 0{
            return "PleaseCompleteAllInformation"
        }
        if (self.emailTextField.text?.trimmingCharacters(in: .whitespaces).characters.count)! < 6{
            return "InvalidUsernamePassword"
        }
        return nil
    }
    func validatePass()->String?{
        if (self.passTextField.text?.trimmingCharacters(in: .whitespaces).characters.count)! == 0{
            return "PleaseCompleteAllInformation"
        }
        if (self.passTextField.text?.trimmingCharacters(in: .whitespaces).characters.count)! < 6{
            return "InvalidUsernamePassword"
        }
        return nil
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
        // MARK: - TEAM LEAD: Fix present to push here
        push(viewController: signUpVC_1)
        //present(viewController: signUpVC_1)
    }
    func handleForgotPassButton(_ sender : UIButton) {
        // MARK: - TEAM LEAD: Fix present to push here
        push(viewController: ForgotPassVC())
        //present(viewController: ForgotPassVC())
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
        UIView.transition(with: appDelegate!.window!!, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            appDelegate?.window??.rootViewController = UINavigationController.init(rootViewController: HomeVC())
        }, completion: nil)
        //self.dismiss(animated: true, completion: nil)
    }
    func handleFacebookAccount() {
        GraphRequest(graphPath: "me", parameters: ["fields" : "id, name, email"], accessToken: AccessToken.current, httpMethod: .GET).start { (response, result) in
            switch result{
            case .failed(let error):
                print(error)
            case .success(let res):
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
                if error == DATA_NOT_EXIST {
                    self.handleSignUpSocical(userInfo: userInfo)
                }else{
                    print(error!)
                }
            }else{
                UserHelpers.save(user: user!, newToken: token!)
                self.presentHome()
            }
        }
    }
    
    func handleSignUpSocical(userInfo: Dictionary<String, String>){
        let signUpSocialVC = SignUpSocialVC()
        signUpSocialVC.userInfo = userInfo
        signUpSocialVC.delegate = self
        // MARK: - TEAM LEAD: Fix present to push here
        push(viewController: signUpSocialVC)
        //present(viewController: signUpSocialVC)
    }
    //MARK: -Google sign in delegate
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
//        self.loadingView.close()
        self.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
        
        } else {
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
    
    override func localized() {
    }
}



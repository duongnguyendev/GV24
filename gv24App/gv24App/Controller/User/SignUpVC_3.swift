//
//  TermVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/10/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC_3: BaseVC {
    
    weak var delegate : UserEventDelegate?
    var user : Dictionary<String, String>?
    var avatarImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LanguageManager.shared.localized(string: "TermsOfUse")
        MoreService.shared.getTerms { (htmlString, error) in
            print(htmlString as Any)
            self.webView.loadHTMLString(htmlString!, baseURL: nil)
        }
        // Do any additional setup after loading the view.
    }
    
//    let logoImage : IconView = {
//        let iv = IconView(image: "logo2", size: 100)
//        return iv
//    }()
    let buttonComplate : BasicButton = {
        let btn = BasicButton()
        btn.title = LanguageManager.shared.localized(string: "Complete")
        btn.addTarget(self, action: #selector(handleButtonComplate(_:)), for: .touchUpInside)
        btn.color = AppColor.homeButton3
        return btn
    }()
//    let labelContent : UILabel = {
//        let lb = UILabel()
//        lb.textAlignment = .justified
//        lb.text = LanguageManager.shared.localized(string: "Terms")
//        lb.numberOfLines = 0
//        lb.translatesAutoresizingMaskIntoConstraints = false
//        lb.font = Fonts.by(name: .regular, size: 14)
//        return lb
//        
//    }()
    
    let webView : UIWebView = {
        let webView = UIWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        return webView
    }()
    
    override func setupView() {
        super.setupView()
        
        view.addSubview(webView)
        view.addSubview(buttonComplate)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: webView)
        
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: buttonComplate)
        
        view.addConstraintWithFormat(format: "V:|[v0]-\(margin)-[v1(40)]-\(margin)-|", views: webView, buttonComplate)
    }
    
    func handleButtonComplate(_ sender : UIButton) {
        self.loadingView.show()
        if let token = FIRInstanceID.instanceID().token() {
            user?["device_token"] = token
        }
        
        UserService.shared.register(info: user!, avatar: avatarImage!) { [weak self] (userRegisted, token, error) in
            self?.loadingView.close()
            if error == nil {
                UserHelpers.save(user: userRegisted!, newToken: token!)
                guard let delegate = self?.delegate else { return }
                delegate.signUpComplete!()
            } else {
                let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
}

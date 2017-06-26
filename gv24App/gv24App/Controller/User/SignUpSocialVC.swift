//
//  SignUpSocialVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/22/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class SignUpSocialVC: SignUpVC_2 {
    
    override var userInfo: Dictionary<String, String>?{
        didSet{
            if let email = userInfo?["email"]{
                self.emailTextField.text = email
                emailTextField.isEnabled = false
            }
            self.imageAvatar.loadImageurl(link: (userInfo?["image"])!)
//            self.imageAvatar.loadImageUsingUrlString(urlString: "https://scontent.xx.fbcdn.net/v/t1.0-1/p200x200/18740207_114394142477650_3589190078270584963_n.jpg?oh=5c8081c320b17254c04801d376038679&oe=59D6DE80")
            fullNameTextField.text = userInfo?["name"]
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageAvatar.isUserInteractionEnabled = false
        // Do any additional setup after loading the view.
    }

    override func handleComplateButton(_ sender: UIButton) {
        activity.startAnimating()
        buttonComplate.isUserInteractionEnabled = false
        validate(completion: { (error) in
            self.buttonComplate.isUserInteractionEnabled = true
            self.activity.stopAnimating()
            if error != nil{
                let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                self.userInfo?["email"] = self.emailTextField.text
                self.userInfo?["name"] = self.fullNameTextField.text
                self.userInfo?["phone"] = self.phoneTextField.text
                self.userInfo?["addressName"] = self.addressTextField.text
                self.userInfo?["lat"] = "\(String(describing: (self.coordinate?.latitude)!))"
                self.userInfo?["lng"] = "\(String(describing: (self.coordinate?.longitude)!))"
                self.userInfo?["gender"] = "\(String(describing: (self.gender)!))"
                let signUpSocialFinalVC = SignUpSocialFinalVC()
                signUpSocialFinalVC.user = self.userInfo
                signUpSocialFinalVC.delegate = self.delegate
                self.push(viewController: signUpSocialFinalVC)
            }
        })
    }

    override func validateAvatar() -> String? {
        return nil
    }
}
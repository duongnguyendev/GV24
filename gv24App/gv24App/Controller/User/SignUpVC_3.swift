//
//  TermVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/10/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import Firebase
class SignUpVC_3: BaseVC{
    
    var delegate : UserEventDelegate?
    var user : Dictionary<String, String>?
    var avatarImage : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LanguageManager.shared.localized(string: "TermsOfUse")
        MoreService.shared.getTerms { (htmlString) in
            print(htmlString as Any)
        }
        // Do any additional setup after loading the view.
    }
    
    let logoImage : IconView = {
        let iv = IconView(image: "logo2", size: 100)
        return iv
    }()
    let buttonComplate : BasicButton = {
        let btn = BasicButton()
        btn.title = LanguageManager.shared.localized(string: "Complete")
        btn.addTarget(self, action: #selector(handleButtonComplate(_:)), for: .touchUpInside)
        btn.color = AppColor.homeButton3
        return btn
    }()
    let labelContent : UILabel = {
        let lb = UILabel()
        lb.textAlignment = .justified
        lb.text = LanguageManager.shared.localized(string: "Terms")
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .regular, size: 14)
        return lb
        
    }()
    
    override func setupView() {
        super.setupView()
        
        let scrollViewContent = UIScrollView()
        let contentView = UIView()
        
        view.addSubview(scrollViewContent)
        scrollViewContent.addSubview(contentView)
        
        scrollViewContent.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollViewContent.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollViewContent.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollViewContent.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollViewContent.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(2 * margin + 40)).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollViewContent.topAnchor, constant: 0).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollViewContent.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollViewContent.rightAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor, constant: 0).isActive = true
        
        contentView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        
        
        view.addSubview(buttonComplate)
        
        view.addConstraintWithFormat(format: "H:|-\(margin)-[v0]-\(margin)-|", views: buttonComplate)
        view.addConstraintWithFormat(format: "V:[v0(40)]-\(margin)-|", views: buttonComplate)
        
        //        contentView.addSubview(logoImage)
        contentView.addSubview(labelContent)
        
        //        contentView.addConstraintWithFormat(format: "V:|-\(margin)-[v0]-\(margin)-[v1]|", views: logoImage, labelContent)
        contentView.addConstraintWithFormat(format: "V:|[v0]|", views: labelContent)
        
        labelContent.widthAnchor.constraint(equalToConstant: view.frame.size.width - (2 * margin)).isActive = true
        labelContent.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        
    }
    
    func handleButtonComplate(_ sender : UIButton){
        
        buttonComplate.isUserInteractionEnabled = false
        activity.startAnimating()
        if let token = FIRInstanceID.instanceID().token(){
            user?["device_token"] = token
        }
        UserService.shared.register(info: user!, avatar: avatarImage!) { (userRegisted, token, error) in
            self.activity.stopAnimating()
            self.buttonComplate.isUserInteractionEnabled = true
            if error == nil{
                UserHelpers.save(user: userRegisted!, token: token!)
                //                self.delegate?.signUpComplete!()
                self.navigationController?.dismiss(animated: true, completion: {
                    self.delegate?.signUpComplete!()
                })
            }else{
                let alert = UIAlertController(title: "Lỗi", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

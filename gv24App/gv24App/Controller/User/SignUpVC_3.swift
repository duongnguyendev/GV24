//
//  TermVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/10/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
class SignUpVC_3: BaseVC{
    
    var delegate : UserEventDelegate?
    var user : Dictionary<String, String>?
    var avatarImage : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Điều khoản"
        // Do any additional setup after loading the view.
    }
    
    let activity : UIActivityIndicatorView = {
        let act = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        act.hidesWhenStopped = true
        act.translatesAutoresizingMaskIntoConstraints = false
        act.layer.zPosition = 1
        return act
        
    }()
    
    let logoImage : IconView = {
        let iv = IconView(image: "logo2", size: 100)
        return iv
    }()
    let buttonComplate : BasicButton = {
        let btn = BasicButton()
        btn.title = "Hoàn thành"
        btn.addTarget(self, action: #selector(handleButtonComplate(_:)), for: .touchUpInside)
        btn.color = AppColor.homeButton3
        return btn
    }()
    let labelContent : UILabel = {
        let lb = UILabel()
        lb.textAlignment = .justified
        lb.text = "\tThe world cellular, as it describes phone technology, was used by engineers Douglas H. Ring and W. Rae Young at Bell Labs. They diagrammed a network of wireless towers into what they called a cellular layout. Cellular was the chosen term because each tower and its coverage map looked like a biological cell. Eventually, phones that operated on this type of wireless network were called cellular phones.\n\n\tThe term mobile phone predates its cellular counterpart. The first mobile phone call was placed in 1946 over Bell System's Mobile telephone service, a closed radiotelephone system. And the first commercial mobile phones were installed cars in the 1970s.\n\n\tEventually, the two names, mobile phone and cellular phone, became synonymous, especially here in the US. But some people disagree with that usage. They consider the term \"cellular phone\" to be a misnomer because the phone is not cellular, the network is. The phone is a mobile phone and it operates on a cellular network."
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .regular, size: 14)
        return lb
        
    }()
    
    override func setupView() {
        super.setupView()
        
        view.addSubview(activity)
        activity.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        activity.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        
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
        //        logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        
        labelContent.widthAnchor.constraint(equalToConstant: view.frame.size.width - (2 * margin)).isActive = true
        labelContent.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        
    }
    
    func handleButtonComplate(_ sender : UIButton){
        
        buttonComplate.isUserInteractionEnabled = false
        activity.startAnimating()
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

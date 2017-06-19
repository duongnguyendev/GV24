//
//  ReportMaidVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/31/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class ReportMaidVC: BaseVC, UITextViewDelegate {
    
    var maid : MaidProfile?{
        didSet{
            self.avatarImageView.loadImageUsingUrlString(urlString: (maid?.avatarUrl)!)
            self.labelName.text = maid?.name
            self.labelAddress.text = maid?.address?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.collection
        title = "Báo cáo"
    }
    
    private let avatarImageView : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "avatar"))
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 25
        iv.layer.masksToBounds = true
        return iv
    }()
    
    private let labelName : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .medium, size: 18)
        lb.text = "Nguyễn Văn A"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let labelAddress : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 13)
        lb.text = "244 Cống Quỳnh, p. Phạm Ngũ Lão, Q.1"
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    private let textViewdContent : UITextView = {
        let tF = UITextView()
        tF.translatesAutoresizingMaskIntoConstraints = false
        tF.text = "Báo cáo"
        tF.font = Fonts.by(name: .regular, size: 15)
        return tF
    }()
    
    override func setupRightNavButton() {
        let buttonSend = NavButton(title: "Send")
        buttonSend.addTarget(self, action: #selector(handleSendButton(_:)), for: .touchUpInside)
        let btn = UIBarButtonItem(customView: buttonSend)
        self.navigationItem.rightBarButtonItem = btn
    }
    
    override func setupView() {
        let userView = UIView()
        userView.backgroundColor = UIColor.white
        userView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(userView)
        
        view.addSubview(avatarImageView)
        view.addSubview(labelName)
        view.addSubview(labelAddress)
        
        userView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        userView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        userView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        userView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        avatarImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        avatarImageView.centerYAnchor.constraint(equalTo: userView.centerYAnchor, constant: 0).isActive = true
        
        labelName.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 20).isActive = true
        labelName.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 0).isActive = true
        
        labelAddress.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 20).isActive = true
        labelAddress.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        labelAddress.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 0).isActive = true
        
        let viewConent = UIView()
        viewConent.translatesAutoresizingMaskIntoConstraints = false
        viewConent.backgroundColor = UIColor.white
        view.addSubview(viewConent)
        viewConent.addSubview(textViewdContent)
        
        viewConent.topAnchor.constraint(equalTo: userView.bottomAnchor, constant: 1).isActive = true
        viewConent.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        viewConent.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        viewConent.heightAnchor.constraint(equalToConstant: 200).isActive = true
        textViewdContent.topAnchor.constraint(equalTo: viewConent.topAnchor, constant: 5).isActive = true
        textViewdContent.leftAnchor.constraint(equalTo: viewConent.leftAnchor, constant: 20).isActive = true
        textViewdContent.rightAnchor.constraint(equalTo: viewConent.rightAnchor, constant: -20).isActive = true
        textViewdContent.bottomAnchor.constraint(equalTo: viewConent.bottomAnchor, constant: 0).isActive = true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    //MARK: - handle button
    
    func handleSendButton(_ sender: UIButton){
        let alert = UIAlertController(title: "", message: "Báo cáo thành công", preferredStyle: .alert)
        var alertAction : UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        if self.textViewdContent.text.trimmingCharacters(in: .whitespaces).characters.count > 10  {
            UserService.shared.report(maidId: (maid?.userId)!, content: textViewdContent.text, completion: { (error) in
                if error != nil{
                    alert.message = error
                }else{
                    alertAction = UIAlertAction(title: "OK", style: .cancel, handler: { (nil) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alert.addAction(alertAction)
                }
                self.present(alert: alert)
            })
        }else{
            alert.message = "Vui lòng nhập nội dung cần báo cáo"
            alert.addAction(alertAction)
            self.present(alert: alert)
        }
    }
    
    func present(alert : UIAlertController){
        
        self.present(alert, animated: true, completion: nil)
    }
}

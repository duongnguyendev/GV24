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
            self.labelName.text = maid?.name
            self.labelAddress.text = maid?.address?.name
            
            guard let urlString = maid?.avatarUrl else { return }
            guard let url = URL.init(string: urlString) else { return }
            self.avatarImageView.af_setImage(withURL: url)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.collection
        title = LanguageManager.shared.localized(string: "TitleFeedback")
    }
    
    private let avatarImageView : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "avatar"))
        iv.contentMode = .scaleAspectFill
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
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
        tF.text = ""
        tF.font = Fonts.by(name: .regular, size: 15)
        return tF
    }()
    
    override func setupRightNavButton() {
        let buttonSend = NavButton(title: "Send")
        buttonSend.addTarget(self, action: #selector(handleSendButton(_:)), for: .touchUpInside)
        let btn = UIBarButtonItem(customView: buttonSend)
        self.navigationItem.rightBarButtonItem = btn
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard textViewdContent.canBecomeFirstResponder == true else { return }
        textViewdContent.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        guard textViewdContent.canResignFirstResponder == true else { return }
        textViewdContent.resignFirstResponder()
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
        let alert = UIAlertController(title: "", message: LanguageManager.shared.localized(string: "ReportSentSuccessfully"), preferredStyle: .alert)
        var alertAction : UIAlertAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        if self.textViewdContent.text.trimmingCharacters(in: .whitespaces).characters.count > 0  {
            UserService.shared.report(maidId: (maid?.userId)!, content: textViewdContent.text, completion: { (error) in
                if error != nil{
                    alert.message = LanguageManager.shared.localized(string: error!)
                }else{
                    alertAction = UIAlertAction(title: "OK", style: .cancel, handler: { (nil) in
                        self.goBack()
                    })
                    alert.addAction(alertAction)
                }
                self.present(alert: alert)
            })
        }else{
            alert.message = LanguageManager.shared.localized(string: "InvalidReportTextCount")
            alert.addAction(alertAction)
            self.present(alert: alert)
        }
    }
    
    func present(alert : UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
}

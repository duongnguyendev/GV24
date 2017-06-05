//
//  BaseLauncher.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class BaseLauncher: NSObject {
    
    let blackView = UIView()
    let contentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    let buttonOK : BasicButton = {
        let btn = BasicButton()
        btn.titleCollor = AppColor.white
        btn.color = AppColor.backButton
        btn.title = "OK"
        return btn
    }()
    
    override init() {
        super.init()
        setupContent()
        setupComponent()
    }
    
    func setupContent(){
        if let window = UIApplication.shared.keyWindow{
            self.blackView.isHidden = true
            self.contentView.isHidden = true
            
            blackView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            window.addSubview(contentView)
            blackView.frame = window.frame
            blackView.alpha = 0
            contentView.centerYAnchor.constraint(equalTo: blackView.centerYAnchor, constant: 0).isActive = true
            contentView.centerXAnchor.constraint(equalTo: blackView.centerXAnchor, constant: 0).isActive = true
        }
    }
    
    func setupComponent(){
        contentView.addSubview(buttonOK)
        buttonOK.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        buttonOK.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        buttonOK.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        buttonOK.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonOK.addTarget(self, action: #selector(handleButtonOK(_:)), for: .touchUpInside)
    }
    func show(){
        self.blackView.isHidden = false
        self.contentView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.contentView.alpha = 1
        }, completion: nil)
    }
    
    func close(){
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            self.contentView.alpha = 0
        }) { (Bool) in
            self.blackView.isHidden = true
            self.contentView.isHidden = true
        }
    }
    
    func handleButtonOK(_ sender : UIButton){
        self.close()
    }
    
}

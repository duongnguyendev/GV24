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
    
    let mainView : UIView = {
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
        setupMainView()
        setupComponent()
    }

    func setupMainView(){
        if let window = UIApplication.shared.keyWindow{
            self.blackView.isHidden = true
            self.mainView.isHidden = true
            
            blackView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            window.addSubview(mainView)
            blackView.frame = window.frame
            blackView.alpha = 0
            mainView.centerYAnchor.constraint(equalTo: blackView.centerYAnchor, constant: 0).isActive = true
            mainView.centerXAnchor.constraint(equalTo: blackView.centerXAnchor, constant: 0).isActive = true
        }
    }
    
    func setupComponent(){
        addContentView()
        setupButton()
        setupSubView()
        
    }
    
    func addContentView(){
        mainView.addSubview(buttonOK)
    }
    
    func setupButton(){
        buttonOK.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true
        buttonOK.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 0).isActive = true
        buttonOK.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 0).isActive = true
        buttonOK.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonOK.addTarget(self, action: #selector(handleButtonOK(_:)), for: .touchUpInside)
    }
    func setupSubView(){
        
    }
    
    func show(){
        self.blackView.isHidden = false
        self.mainView.isHidden = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.mainView.alpha = 1
        }, completion: nil)
    }
    
    func close(){
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            self.mainView.alpha = 0
        }) { (Bool) in
            self.blackView.isHidden = true
            self.mainView.isHidden = true
        }
    }
    
    func handleButtonOK(_ sender : UIButton){
        self.close()
    }
    
}

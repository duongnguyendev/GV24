//
//  LoadingView.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 7/3/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class LoadingView: NSObject {
    private let blackView = UIView()
    private let mainView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.widthAnchor.constraint(equalToConstant: 50).isActive = true
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    private let activity : UIActivityIndicatorView = {
        let act = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        act.hidesWhenStopped = true
        act.translatesAutoresizingMaskIntoConstraints = false
        act.startAnimating()
        return act
    }()
    override init() {
        super.init()
        
    }
    
    func setupMainView(){
        if let window = UIApplication.shared.keyWindow{
            self.blackView.isHidden = true
            self.mainView.isHidden = true

            blackView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            window.addSubview(mainView)
            mainView.addSubview(activity)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            mainView.centerYAnchor.constraint(equalTo: blackView.centerYAnchor, constant: 0).isActive = true
            mainView.centerXAnchor.constraint(equalTo: blackView.centerXAnchor, constant: 0).isActive = true
            
            activity.centerXAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 0).isActive = true
            activity.centerYAnchor.constraint(equalTo: mainView.centerYAnchor, constant: 0).isActive = true
        }
    }
    
    func show(){
        setupMainView()
        self.blackView.isHidden = false
        self.mainView.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.mainView.alpha = 1
        }, completion: nil)
    }
    
    func close(){
        UIView.animate(withDuration: 0.3, animations: {
            self.blackView.alpha = 0
            self.mainView.alpha = 0
        }) { (Bool) in
            self.blackView.isHidden = true
            self.mainView.isHidden = true
        }
    }
}


class InternetDisconnectView: NSObject {
    private let blackView = UIView()
    private let mainView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LanguageManager.shared.localized(string: "NoInternetConnection")
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        label.font = Fonts.by(name: .medium, size: 20)
        label.textAlignment = .center
        return view
    }()
    override init() {
        super.init()
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
            mainView.topAnchor.constraint(equalTo: blackView.topAnchor, constant: 0).isActive = true
            mainView.leftAnchor.constraint(equalTo: blackView.leftAnchor, constant: 0).isActive = true
        }
    }
    
    func show(){
        setupMainView()
        self.blackView.isHidden = false
        self.mainView.isHidden = false
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            self.mainView.alpha = 1
        }, completion: nil)
    }
    
    func close(){
        UIView.animate(withDuration: 0.3, animations: {
            self.blackView.alpha = 0
            self.mainView.alpha = 0
        }) { (Bool) in
            self.blackView.isHidden = true
            self.mainView.isHidden = true
        }
    }
}

//
//  HomeVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/3/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import IoniconsSwift

class HomeVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    let backGroundView : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "bg_app"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !UserHelpers.isLogin {
            self.dismiss(animated: false, completion: nil)
        }

    }
    
    let aroundButton : HomeFunctButton = {
        let bt = HomeFunctButton()
        bt.backgroundColor = AppColor.homeButton1
        bt.imageName = "quanh_day"
        bt.title = "Giúp việc\nquanh đây"
        bt.addTarget(self, action: #selector(handleButtonAround(_:)), for: .touchUpInside)
        return bt
    }()
    let taskManagerButton : HomeFunctButton = {
        let bt = HomeFunctButton()
        bt.backgroundColor =  AppColor.homeButton2
        bt.imageName = "quan_ly"
        bt.addTarget(self, action: #selector(handleButtonTaskManagement(_:)), for: .touchUpInside)
        return bt
    }()
    let historyButton : HomeFunctButton = {
        let bt = HomeFunctButton()
        bt.backgroundColor =  AppColor.homeButton3
        bt.imageName = "lich_su"
        bt.addTarget(self, action: #selector(handleButtonHistory(_:)), for: .touchUpInside)
        return bt
    }()
    let sloganView : HomeBottomView = {
        let v = HomeBottomView()
        return v
    }()
    
    override func setupView() {
        setupBackGround()
        view.addSubview(sloganView)
        view.addSubview(aroundButton)
        view.addSubview(taskManagerButton)
        view.addSubview(historyButton)
        
        let buttonSize = view.frame.size.width / 3
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: sloganView)
        view.addConstraintWithFormat(format: "V:[v0(\(buttonSize - 30))]|", views: sloganView)
        
        view.addConstraintWithFormat(format: "H:|[v0(\(buttonSize))][v1(\(buttonSize))][v2]|", views: aroundButton, taskManagerButton, historyButton)
        
        aroundButton.heightAnchor.constraint(equalToConstant: buttonSize - 20).isActive = true
        taskManagerButton.heightAnchor.constraint(equalToConstant: buttonSize - 20).isActive = true
        historyButton.heightAnchor.constraint(equalToConstant: buttonSize - 20).isActive = true
        
        aroundButton.bottomAnchor.constraint(equalTo: sloganView.topAnchor, constant: 0).isActive = true
        taskManagerButton.bottomAnchor.constraint(equalTo: sloganView.topAnchor, constant: 0).isActive = true
        historyButton.bottomAnchor.constraint(equalTo: sloganView.topAnchor, constant: 0).isActive = true
        
    }
    
    override func setupRightNavButton() {
        let buttonMore = NavButton(icon: .more)
        buttonMore.addTarget(self, action: #selector(handleButtonMore(_:)), for: .touchUpInside)
        let btn = UIBarButtonItem(customView: buttonMore)
        self.navigationItem.rightBarButtonItem = btn
    }
    
    
    func setupBackGround(){
        
        view.addSubview(backGroundView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: backGroundView)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: backGroundView)
    }
    
    //MARK: - Handle button
    func handleButtonMore(_ sender : UIButton) {
        let moreVC = MoreVC()
        present(viewController: moreVC)
    }
    
    func handleButtonAround(_ sender : UIButton){
        present(viewController: MaidAroundVC())
    }
    func handleButtonTaskManagement(_ sender : UIButton){
        present(viewController: TaskManagementVC())
    }
    func handleButtonHistory(_ sender : UIButton){
        present(viewController: HistoryVC())
    }
    
    //MARK: - localize
    override func localized(){
        title = LanguageManager.shared.localized(string: "Home")
        aroundButton.title = "Around"
        historyButton.title = "WorkHistory"
        taskManagerButton.title = "WorkManagement"
        sloganView.slogan = "TrustQuality"
    }
}

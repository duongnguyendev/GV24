//
//  JobProgressDetailVC.swift
//  gv24App
//
//  Created by Macbook Solution on 5/26/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class JobProgressDetailVC: BaseVC {
    
    private let profileButton: ProfileUserButton = {
        let button = ProfileUserButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleButtonProfile(_:)), for: .touchUpInside)
        return button
    }()
    
    private let finishMaid: IconTextButton = {
        let button = IconTextButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "ConformedMaid"
        button.addTarget(self, action: #selector(handleButtonConformMaid(_:)), for: .touchUpInside)
        button.sizeImage = 20
        button.color = AppColor.backButton
        button.iconName = .logOut
        return button
    }()
    
    let descTaskView: DescTaskView = {
        let view = DescTaskView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func handleButtonProfile(_ sender: UIButton){
        print("Click Profile Button")
    }
    func handleButtonConformMaid(_ sender: IconTextButton){
        print("Click Conform Maid Button")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.collection
        title = "Đang làm"
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func setupView() {
        super.setupView()
        self.view.addSubview(profileButton)
        self.view.addSubview(finishMaid)
        self.view.addSubview(descTaskView)

        view.addConstraintWithFormat(format: "H:|[v0]|", views: profileButton)
        profileButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: finishMaid)
        finishMaid.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 1).isActive = true
        finishMaid.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        descTaskView.topAnchor.constraint(equalTo: finishMaid.bottomAnchor, constant: 20).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: descTaskView)
        descTaskView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }

}

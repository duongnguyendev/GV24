//
//  JobAssignedDetailVC.swift
//  gv24App
//
//  Created by Macbook Solution on 5/26/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class JobAssignedDetailVC: BaseVC{
    var taskAssigned = TaskAssigned()
    let mainScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let contentView : UIView = {
        //content all view
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let profileButton: ProfileUserButton = {
        let button = ProfileUserButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleProfileButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private let conformedMaid: IconTextButton = {
        let button = IconTextButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = LanguageManager.shared.localized(string: "ConformedMaid")
        button.addTarget(self, action: #selector(handleConformMaid(_:)), for: .touchUpInside)
        button.sizeImage = 20
        button.color = AppColor.backButton
        button.iconName = .logIn
        return button
    }()
    
    let descTaskView: DescTaskView = {
        let view = DescTaskView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let deleteButton: IconTextButton = {
        let button = IconTextButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.color = AppColor.homeButton1
        button.addTarget(self, action: #selector(handleRemoveTask(_:)), for: .touchUpInside)
        button.sizeImage = 30
        button.title = LanguageManager.shared.localized(string: "RemoveTask")
        button.backgroundColor = UIColor.white
        button.iconName = .iosTrash
        return button
    }()
    
    func handleProfileButton(_ sender: UIButton){
        print("Handle Profile Button")
    }
    func handleConformMaid(_ sender: UIButton){
         print("Handle Comform Task")
    }
    func handleRemoveTask(_ sender: UIButton){
        print("Handle Remove Task")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.collection
         title = "Đã phân công"
    }
    override func viewWillAppear(_ animated: Bool) {
        self.descTaskView.task = taskAssigned
        self.profileButton.received = taskAssigned.received
    }
    
    override func setupView() {
        super.setupView()
        view.addSubview(mainScrollView)
        self.mainScrollView.addSubview(contentView)
        self.contentView.addSubview(profileButton)
        self.contentView.addSubview(conformedMaid)
        self.contentView.addSubview(descTaskView)
        self.contentView.addSubview(deleteButton)
        
        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        contentView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        contentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 0).isActive = true
        contentView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: 0).isActive = true

        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: profileButton)
        profileButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: conformedMaid)
        conformedMaid.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 1).isActive = true
        conformedMaid.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        descTaskView.topAnchor.constraint(equalTo: conformedMaid.bottomAnchor, constant: 20).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: descTaskView)
        descTaskView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        deleteButton.topAnchor.constraint(equalTo: descTaskView.bottomAnchor, constant: 40).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: deleteButton)
        deleteButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
        
    }
}

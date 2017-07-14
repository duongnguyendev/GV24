//
//  JobNewDetailVC.swift
//  gv24App
//
//  Created by Macbook Solution on 6/14/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class JobNewDetailVC: JobDetailVC{
    var task = Task()
    let deleteButton: IconTextButton = {
        let button = IconTextButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.color = AppColor.homeButton1
        button.addTarget(self, action: #selector(handleRemoveTask(_:)), for: .touchUpInside)
        button.title = LanguageManager.shared.localized(string: "DeleteWork")
        button.sizeImage = 30
        button.iconName = .iosTrash
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.descTaskView.task = task
    }
    override func setupView() {
        super.setupView()
        view.addSubview(deleteButton)
        
        deleteButton.topAnchor.constraint(equalTo: descTaskView.bottomAnchor, constant: 40).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: deleteButton)
        deleteButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    override func setupRightNavButton() {
        let buttonSend = NavButton(icon: .edit, size: CGSize(width: 20, height: 20))
        buttonSend.addTarget(self, action: #selector(handleUpdateButton(_:)), for: .touchUpInside)
        let btn = UIBarButtonItem(customView: buttonSend)
        self.navigationItem.rightBarButtonItem = btn
    }
    
    func handleRemoveTask(_ sender: UIButton){
        self.showAlertWith(task: task)
        print("Handle Remove Task")
    }
    
    func handleUpdateButton(_ sender: UIButton){
        let updateVC = UpdateVC()
        updateVC.task = task
        push(viewController: updateVC)
        print("Handle Update Task")
    }
    
    override func localized() {
        super.localized()
        title = LanguageManager.shared.localized(string: "PostedWork")
    }
}

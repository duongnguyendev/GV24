//
//  JobExpiredDetailVC.swift
//  gv24App
//
//  Created by Macbook Solution on 6/14/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class JobExpiredDetailVC: JobDetailVC{
    var task = Task()
    let labelExpired : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.widthAnchor.constraint(equalToConstant: 70).isActive = true
        lb.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lb.font = Fonts.by(name: .light, size: 13)
        lb.textColor = UIColor.white
        lb.backgroundColor = UIColor.lightGray
        lb.layer.cornerRadius = 10
        lb.layer.masksToBounds = true
        lb.textAlignment = .center
        lb.text = LanguageManager.shared.localized(string: "ExceededTask")
        return lb
    }()
    
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
    override func setupView() {
        super.setupView()
        view.addSubview(labelExpired)
        view.addSubview(deleteButton)
        
        labelExpired.rightAnchor.constraint(equalTo: descTaskView.rightAnchor, constant: -(margin/3)).isActive = true
        labelExpired.topAnchor.constraint(equalTo: descTaskView.topAnchor, constant: margin/3).isActive = true
        
        deleteButton.topAnchor.constraint(equalTo: descTaskView.bottomAnchor, constant: 40).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: deleteButton)
        deleteButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.descTaskView.task = task
    }
    
    func handleRemoveTask(_ sender: UIButton){
        self.showAlertWith(task: task)
        print("Handle Remove Task")
    }
    override func localized() {
        super.localized()
        title = LanguageManager.shared.localized(string: "Posted")
    }
}

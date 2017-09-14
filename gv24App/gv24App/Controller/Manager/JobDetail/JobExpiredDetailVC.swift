//
//  JobExpiredDetailVC.swift
//  gv24App
//
//  Created by Macbook Solution on 6/14/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class JobExpiredDetailVC: JobDetailVC {
    
    var task = Task() {
        didSet {
            self.descTaskView.task = task
        }
    }
    
    let labelExpired : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.widthAnchor.constraint(equalToConstant: 70).isActive = true
        lb.heightAnchor.constraint(equalToConstant: 25).isActive = true
        lb.font = Fonts.by(name: .light, size: 13)
        lb.textColor = UIColor.white
        lb.backgroundColor = UIColor.lightGray
        lb.layer.cornerRadius = 12.5
        lb.layer.masksToBounds = true
        lb.textAlignment = .center
        lb.text = LanguageManager.shared.localized(string: "ExpiredTask")
        return lb
    }()
    
    let deleteButton: IconTextButton = {
        let button = IconTextButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.color = AppColor.white
        button.addTarget(self, action: #selector(handleRemoveTask(_:)), for: .touchUpInside)
        button.title = LanguageManager.shared.localized(string: "DeleteWork")
//        button.sizeImage = 30
        button.backgroundColor = AppColor.buttonDelete
        //button.iconName = .iosTrash
        return button
    }()

    override func setupView() {
        super.setupView()
        contentView.addSubview(labelExpired)
        contentView.addSubview(deleteButton)
        UIButton.corneRadius(bt: deleteButton)
        descTaskView.labelTitle.rightAnchor.constraint(equalTo: labelExpired.leftAnchor, constant: -10).isActive = true
        
        labelExpired.rightAnchor.constraint(equalTo: descTaskView.rightAnchor, constant: -margin/3).isActive = true
        
        labelExpired.topAnchor.constraint(equalTo: descTaskView.topAnchor, constant: margin/3).isActive = true
        
        deleteButton.topAnchor.constraint(equalTo: descTaskView.bottomAnchor, constant: 40).isActive = true
        deleteButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        deleteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: deleteButton)
        deleteButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        deleteButton.backgroundColor = AppColor.buttonDelete
        contentView.bottomAnchor.constraint(greaterThanOrEqualTo: deleteButton.bottomAnchor, constant: 20).isActive = true
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

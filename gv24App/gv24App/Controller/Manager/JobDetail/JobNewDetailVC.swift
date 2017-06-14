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
    
    let deleteButton: IconTextButton = {
        let button = IconTextButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.color = AppColor.homeButton1
        button.addTarget(self, action: #selector(handleRemoveTask(_:)), for: .touchUpInside)
        button.title = LanguageManager.shared.localized(string: "RemoveTask")
        button.sizeImage = 30
        button.iconName = .iosTrash
        return button
    }()

    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func setupView() {
        super.setupView()
        view.addSubview(deleteButton)
        
        deleteButton.topAnchor.constraint(equalTo: descTaskView.bottomAnchor, constant: 40).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: deleteButton)
        deleteButton.heightAnchor.constraint(equalToConstant: 45).isActive = true

    }
    
    func handleRemoveTask(_ sender: UIButton){
        print("Handle Remove Task")
    }
    

}

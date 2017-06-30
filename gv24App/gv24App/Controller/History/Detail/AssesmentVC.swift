//
//  AssesmentVC.swift
//  gv24App
//
//  Created by dinhphong on 6/23/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class AssesmentVC: DetailTaskDoneVC {
    
    private let commentButton: GeneralButton = {
        let button = GeneralButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = LanguageManager.shared.localized(string: "Addcomments")
        button.color = AppColor.backButton
        button.addTarget(self, action: #selector(handleButtonComment(_:)), for: .touchUpInside)
        return button
    }()

    func handleButtonComment(_ sender: UIButton){
        let commentVC = CommentMaidVC()
        commentVC.maid = taskHistory.stakeholder?.receivced
        commentVC.id = taskHistory.id
        push(viewController: commentVC)
        print("Click Button Comment")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func setupView() {
        super.setupView()
        mainView.addSubview(commentButton)
        
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: commentButton)
        commentButton.topAnchor.constraint(equalTo: horizontalStatusTaskLine.topAnchor, constant: 1).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        commentButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -30).isActive = true
    }

}

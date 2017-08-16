//
//  JobRequestDetailVC.swift
//  gv24App
//
//  Created by dinhphong on 6/29/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class JobRequestDetailVC: BaseVC {
    var taskRequest = Task()
    
    private let profileButton: ProfileUserButton = {
        let button = ProfileUserButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleButtonProfile(_:)), for: .touchUpInside)
        return button
    }()
    let descLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = LanguageManager.shared.localized(string: "Description")
        lb.textColor = AppColor.lightGray
        return lb
    }()
    let descTaskView: DescTaskView = {
        let view = DescTaskView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let mainScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var descTaskViewHeightConstraint: NSLayoutConstraint?

    func handleButtonProfile(_ sender: UIButton){
        let maidProfileVC = MaidProfileVC()
        maidProfileVC.maid = taskRequest.stakeholder?.receivced
        push(viewController: maidProfileVC)
        print("Click Profile Button")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.collection
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.descTaskView.task = taskRequest
        self.profileButton.received = taskRequest.stakeholder?.receivced
    }
    
    override func setupView() {
        super.setupView()
        
        self.view.addSubview(mainScrollView)
        mainScrollView.addSubview(contentView)
        
        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        contentView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        contentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 0).isActive = true
        contentView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: 0).isActive = true
        
        contentView.addSubview(profileButton)
        contentView.addSubview(descLabel)
        contentView.addSubview(descTaskView)
        
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: profileButton)
        profileButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 20).isActive = true
        descLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        
        descTaskView.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 20).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: descTaskView)
        contentView.bottomAnchor.constraint(greaterThanOrEqualTo: descTaskView.bottomAnchor, constant: 20).isActive = true
        
        descTaskViewHeightConstraint = descTaskView.heightAnchor.constraint(equalToConstant: 300)
        descTaskViewHeightConstraint?.isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        descTaskViewHeightConstraint?.constant = descTaskView.preferredHeight
    }
    
    override func localized() {
        super.localized()
        title = LanguageManager.shared.localized(string: "PostedWork")
    }
    
}

//
//  DetailTaskHistoryVC.swift
//  gv24App
//
//  Created by Macbook Solution on 6/6/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class DetailTaskDoneVC: BaseVC{
    var taskHistory = Task()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainScrollView.backgroundColor = AppColor.collection
        title = LanguageManager.shared.localized(string: "WorkDone")
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        descTaskView.task = taskHistory
        profileButton.received = taskHistory.stakeholder?.receivced
    }
    let mainScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let mainView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let profileButton: ProfileUserButton = {
        let button = ProfileUserButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleButtonProfile(_:)), for: .touchUpInside)
        return button
    }()
    
    private let descTaskView: DescTaskView = {
        let view = DescTaskView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var descTaskViewHeightContraint: NSLayoutConstraint?
    
    private let label: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = LanguageManager.shared.localized(string: "Doer")
        lb.textColor = AppColor.lightGray
        return lb
    }()
    
    private let statusView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AppColor.white
        return view
    }()
    
    private let statusLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = LanguageManager.shared.localized(string: "ThisWorkIsCompleted")
        lb.textColor = AppColor.lightGray
        lb.backgroundColor = AppColor.white
        return lb
    }()
    
    private let horizontalProfileButtonLine = UIView.horizontalLine()
    let horizontalStatusTaskLine = UIView.horizontalLine()
    
    func handleButtonProfile(_ sender: UIButton){
        let maidProfileVC = MaidProfileHistoryVC()
        maidProfileVC.maidHistory = taskHistory.stakeholder?.receivced
        push(viewController: maidProfileVC)
        print("Click Button Profile")
    }
    override func setupView() {
        super.setupView()
        self.setupMainView()
        self.setupSubView()
        self.setupStatusTaskView()
    }
    
    private func setupMainView(){
        self.view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainView)
        
        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        mainView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        mainView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 0).isActive = true
        mainView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor, constant: 0).isActive = true
        mainView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: 0).isActive = true
    }
    
    func setupSubView(){
        mainView.addSubview(descTaskView)
        mainView.addSubview(label)
        mainView.addSubview(profileButton)
        mainView.addSubview(horizontalProfileButtonLine)
        mainView.addSubview(horizontalStatusTaskLine)
        
        descTaskViewHeightContraint = descTaskView.heightAnchor.constraint(equalToConstant: descTaskView.preferredHeight)
        descTaskViewHeightContraint?.isActive = true
        mainView.addConstraintWithFormat(format: "V:|-20-[v0]", views: descTaskView)
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: descTaskView)
        
        label.topAnchor.constraint(equalTo: descTaskView.bottomAnchor, constant: 20).isActive = true
        mainView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: label)
        
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: profileButton)
        profileButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: horizontalProfileButtonLine)
        horizontalProfileButtonLine.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 0).isActive = true
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        descTaskViewHeightContraint?.constant = descTaskView.preferredHeight
    }
    
    func setupStatusTaskView(){
        mainView.addSubview(statusView)
        statusView.addSubview(statusLabel)
        
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: statusView)
        statusView.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 1).isActive = true
        statusView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        statusView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: statusLabel)
        statusLabel.centerYAnchor.constraint(equalTo: statusView.centerYAnchor, constant: 0).isActive = true
        
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: horizontalStatusTaskLine)
        horizontalStatusTaskLine.topAnchor.constraint(equalTo: statusView.bottomAnchor, constant: 0).isActive = true
    }
}

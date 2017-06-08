//
//  DetailTaskHistoryVC.swift
//  gv24App
//
//  Created by Macbook Solution on 6/6/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class DetailTaskHistoryVC: BaseVC{
    
    var taskHistory = Task()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainScrollView.backgroundColor = AppColor.collection
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
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
    private let label: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Người Thực Hiện"
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
        lb.text = "Công việc đã hoàn thành"
        lb.textColor = AppColor.lightGray
        lb.backgroundColor = AppColor.white
        return lb
    }()
    
    private let commentButton: GeneralButton = {
        let button = GeneralButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = "Nhận xét của bạn"
        button.color = AppColor.backButton
        button.addTarget(self, action: #selector(handleButtonComment(_:)), for: .touchUpInside)
        return button
    }()
    private let horizontalProfileButtonLine = UIView.horizontalLine()
    private let horizontalStatusTaskLine = UIView.horizontalLine()
    
    func handleButtonComment(_ sender: UIButton){
        print("Click Button Comment")
    }
    func handleButtonProfile(_ sender: UIButton){
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
        mainView.addSubview(commentButton)
        
        mainView.addConstraintWithFormat(format: "V:|-20-[v0(300)]", views: descTaskView)
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: descTaskView)
        
        label.topAnchor.constraint(equalTo: descTaskView.bottomAnchor, constant: 20).isActive = true
        mainView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: label)
        
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: profileButton)
        profileButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: horizontalProfileButtonLine)
        horizontalProfileButtonLine.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 0).isActive = true
        
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
        
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: commentButton)
        commentButton.topAnchor.constraint(equalTo: horizontalStatusTaskLine.topAnchor, constant: 1).isActive = true
        commentButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        commentButton.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -30).isActive = true
    }
}

//
//  JobPostedDetailVC.swift
//  gv24App
//
//  Created by Macbook Solution on 5/26/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
import IoniconsSwift
@objc protocol TaskManageDelegate {
    @objc optional func chooseMaid()
    @objc optional func checkInMaid()
    
}
class JobPostedDetailVC: JobDetailVC{
    
    var task = Task()
    var delegate: TaskManageDelegate?
    
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
    
    let appListButton: ApplicantListButton = {
        let button = ApplicantListButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.color = AppColor.backButton
        button.addTarget(self, action: #selector(handleAppListTask(_:)), for: .touchUpInside)
        button.status = "2"
        button.title = LanguageManager.shared.localized(string: "ApplicantList")
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.descTaskView.task = task
        self.appListButton.status = "\((task.stakeholder?.request?.count)!)"
    }
    
    override func setupView() {
        super.setupView()
        self.view.addSubview(deleteButton)
        self.view.addSubview(appListButton)
        
        appListButton.topAnchor.constraint(equalTo: descTaskView.bottomAnchor, constant: 20).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: appListButton)
        appListButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        deleteButton.topAnchor.constraint(equalTo: appListButton.bottomAnchor, constant: 20).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: deleteButton)
        deleteButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    func handleRemoveTask(_ sender: UIButton){
        self.showAlertWith(task: task)
        print("Handle Remove Task")
    }
    
    func handleAppListTask(_ sender: UIButton){
        self.loadingView.show()
        TaskManageService.shared.fetchApplicants(id: task.id!) { (applicants, error) in
            if error == nil{
                self.loadingView.close()
                let applicantVC = ApplicantsVC()
                applicantVC.delegate = self.delegate
                applicantVC.applicants = applicants!
                self.push(viewController: applicantVC)
            }else{
                
            }
        }
    }
    override func localized() {
        super.localized()
        title = LanguageManager.shared.localized(string: "Posted")
    }
}

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
class JobPostedDetailVC: JobDetailVC{
    var task = Task()
    
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
        self.descTaskView.task = task
        self.appListButton.status = "\((task.stakeholder?.request?.count)!)"
    }
    
    override func setupView() {
        super.setupView()
        self.view.addSubview(deleteButton)
        self.view.addSubview(appListButton)
        
        appListButton.topAnchor.constraint(equalTo: descTaskView.bottomAnchor, constant: 20).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: appListButton)
        appListButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        deleteButton.topAnchor.constraint(equalTo: appListButton.bottomAnchor, constant: 20).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: deleteButton)
        deleteButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func handleRemoveTask(_ sender: UIButton){
        print("Handle Remove Task")
    }
    
    func handleAppListTask(_ sender: UIButton){
        TaskManageService.shared.fetchApplicants(id: task.id!) { (applicants, error) in
            if error == nil{
                let applicantVC = ApplicantsVC()
                applicantVC.applicants = applicants!
                self.push(viewController: applicantVC)
            }
        }
       
    }

}

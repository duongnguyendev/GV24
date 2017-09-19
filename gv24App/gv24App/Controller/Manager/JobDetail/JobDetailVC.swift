//
//  JobDetailVC.swift
//  gv24App
//
//  Created by Macbook Solution on 6/14/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class JobDetailVC: BaseVC {
    
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
        scrollView.bounces = true
        scrollView.alwaysBounceVertical = true
        scrollView.isDirectionalLockEnabled = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var contentViewTopConstraint : NSLayoutConstraint!
    var descTaskViewHeightConstraint: NSLayoutConstraint?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        descTaskViewHeightConstraint?.constant = descTaskView.preferredHeight
    }
    
    override func setupView() {
        super.setupView()

        self.view.addSubview(mainScrollView)
        mainScrollView.addSubview(contentView)
        contentView.addSubview(descTaskView)
        contentView.addSubview(descLabel)
        
        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        contentView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        
        self.contentViewTopConstraint = NSLayoutConstraint.init(item: self.contentView, attribute: .top, relatedBy: .equal, toItem: self.mainScrollView, attribute: .top, multiplier: 1.0, constant: 0.0)
        self.contentViewTopConstraint.isActive = true
        mainScrollView.addConstraint(self.contentViewTopConstraint)
        
        contentView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: 0).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        descLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        
        descTaskView.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 10).isActive = true
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: descTaskView)
        
        contentView.bottomAnchor.constraint(greaterThanOrEqualTo: descTaskView.bottomAnchor, constant: 20).isActive = true
        
        descTaskViewHeightConstraint = descTaskView.heightAnchor.constraint(equalToConstant: 300)
        descTaskViewHeightConstraint?.isActive = true
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        descTaskViewHeightConstraint?.constant = descTaskView.preferredHeight
    }
    
    func showAlertWith(task: Task){
        let alertController = UIAlertController(title: "", message: LanguageManager.shared.localized(string: "AreYouSureYouWantToDeleteThisWork"), preferredStyle:UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: LanguageManager.shared.localized(string: "OK"), style: UIAlertActionStyle.default){ action -> Void in
            TaskService.shared.deleteTask(task: task, completion: { (flag) in
                if (flag!){
                    self.goBack()
                }else{
                    self.showAlertError(message: LanguageManager.shared.localized(string: "FailedToDelete")!, completion: {})
                }
            })
        })
        alertController.addAction(UIAlertAction(title: LanguageManager.shared.localized(string: "Cancel"), style: UIAlertActionStyle.cancel){ action -> Void in})
        
        self.presentAlert(alert: alertController)
    }
    func showAlertError(message: String, completion: @escaping (()->())){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LanguageManager.shared.localized(string: "OK"), style: .cancel, handler: { (nil) in
            completion()
        }))
        self.presentAlert(alert: alert)
    }

    func presentAlert(alert: UIAlertController){
        self.present(alert, animated: true, completion: nil)
    }
}

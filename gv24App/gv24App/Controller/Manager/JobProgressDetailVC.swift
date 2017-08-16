//
//  JobProgressDetailVC.swift
//  gv24App
//
//  Created by Macbook Solution on 5/26/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class JobProgressDetailVC: BaseVC {
    var taskProgress = Task()
    private let profileButton: ProfileUserButton = {
        let button = ProfileUserButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleButtonProfile(_:)), for: .touchUpInside)
        return button
    }()
    private let finishMaid: IconTextButton = {
        let button = IconTextButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.title = LanguageManager.shared.localized(string: "CompleteWorkProgress")
        button.addTarget(self, action: #selector(handleButtonFinishMaid(_:)), for: .touchUpInside)
        button.sizeImage = 20
        button.color = AppColor.backButton
        button.iconName = .logOut
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
        maidProfileVC.maid = taskProgress.stakeholder?.receivced
        push(viewController: maidProfileVC)
        print("Click Profile Button")
    }
    func handleButtonFinishMaid(_ sender: UIButton){
        self.loadingView.show()
        TaskService.shared.checkOutMaid(id: taskProgress.id!) { (workSuccess) in
            self.loadingView.close()
            if let work = workSuccess{
                let paymentVC = PaymentVC()
                paymentVC.workSuccess = work
                paymentVC.taskProgress = self.taskProgress
                self.push(viewController: paymentVC)
            }else{
                self.showAlertError(message: LanguageManager.shared.localized(string: "ThisWorkIsCompleted")!, completion: {})
            }
        }
    }
    //Mark: Show-Alert
    func showAlertError(message: String, completion: @escaping (()->())){
        let mes = LanguageManager.shared.localized(string: message)
        let alert = UIAlertController(title: nil, message: mes, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LanguageManager.shared.localized(string: "OK"), style: .cancel, handler: { (nil) in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.collection
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.descTaskView.task = taskProgress
        self.profileButton.received = taskProgress.stakeholder?.receivced
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
        contentView.addSubview(finishMaid)
        contentView.addSubview(descTaskView)
        contentView.addSubview(descLabel)
        
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: profileButton)
        profileButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        profileButton.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        contentView.addConstraintWithFormat(format: "H:|[v0]|", views: finishMaid)
        finishMaid.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 1).isActive = true
        finishMaid.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: finishMaid.bottomAnchor, constant: 20).isActive = true
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
        title = LanguageManager.shared.localized(string: "RunningWork")
    }

}

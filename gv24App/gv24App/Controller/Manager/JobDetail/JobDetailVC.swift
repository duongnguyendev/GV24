//
//  JobDetailVC.swift
//  gv24App
//
//  Created by Macbook Solution on 6/14/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class JobDetailVC: BaseVC{
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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.collection
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func setupView() {
        super.setupView()
        self.view.addSubview(descTaskView)
        self.view.addSubview(descLabel)
        
        descLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        descLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        
        descTaskView.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 10).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: descTaskView)
        descTaskView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    func showAlertWith(task: Task){
        let alertController = UIAlertController(title: "", message: LanguageManager.shared.localized(string: "ShowDeleteWork"), preferredStyle:UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default){ action -> Void in
            TaskService.shared.deleteTask(task: task, completion: { (flag) in
                if (flag!){
                    self.goBack()
                }else{
                    self.showAlertError(message: "Xóa bài đăng không thành công", completion: {})
                }
            })
        })
        alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel){ action -> Void in})
        
        self.presentAlert(alert: alertController)
    }
    func showAlertError(message: String, completion: @escaping (()->())){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (nil) in
            completion()
        }))
        self.presentAlert(alert: alert)
    }

    func presentAlert(alert: UIAlertController){
        self.present(alert, animated: true, completion: nil)
    }
}

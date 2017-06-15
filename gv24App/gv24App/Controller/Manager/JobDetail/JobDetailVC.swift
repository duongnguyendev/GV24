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
        lb.text = "Mô tả"
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
}

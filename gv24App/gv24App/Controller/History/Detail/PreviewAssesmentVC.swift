//
//  PreviewAssesmentVC.swift
//  gv24App
//
//  Created by dinhphong on 6/23/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class PreviewAssesmentVC: DetailTaskDoneVC{
    
    private let labelContent: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Bạn siêng năng,dọn phòng đúng sạch sẽ gọn gàng,đi đúng giờ."
        lb.textColor = .black
        lb.font = Fonts.by(name: .regular, size: 16)
        lb.backgroundColor = .clear
        lb.numberOfLines = 2
        return lb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func setupView() {
        super.setupView()
        let viewConent = UIView()
        viewConent.translatesAutoresizingMaskIntoConstraints = false
        viewConent.backgroundColor = UIColor.white
        mainView.addSubview(viewConent)
        viewConent.addSubview(labelContent)
        
        viewConent.topAnchor.constraint(equalTo: horizontalStatusTaskLine.bottomAnchor, constant: 1).isActive = true
        viewConent.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 0).isActive = true
        viewConent.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 0).isActive = true
        viewConent.heightAnchor.constraint(equalToConstant: 70).isActive = true
        viewConent.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10).isActive = true
        
        labelContent.centerYAnchor.constraint(equalTo: viewConent.centerYAnchor).isActive = true
        labelContent.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 10).isActive = true
        labelContent.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 10).isActive = true
    }
}

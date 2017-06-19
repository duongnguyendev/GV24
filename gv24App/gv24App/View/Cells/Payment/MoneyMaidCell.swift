//
//  MoneyMaidCell.swift
//  gv24App
//
//  Created by dinhphong on 6/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class MoneyMaidCell: BaseCollectionCell{
    let moneyView: DescInfoView = {
        let view = DescInfoView()
        view.icon = .socialUsd
        view.name = "500.000 VND"
        return view
    }()
    override func setupView() {
        super.setupView()
        addSubview(moneyView)
        moneyView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        addConstraintWithFormat(format: "H:|[v0]|", views: moneyView)
        moneyView.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
}

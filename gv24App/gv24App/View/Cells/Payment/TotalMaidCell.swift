//
//  TotalMaidCell.swift
//  gv24App
//
//  Created by dinhphong on 6/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class TotalMaidCell: BaseCollectionCell{
    
    var total: String? {
        didSet{
            labelTotal.text = "\(LanguageManager.shared.localized(string: "TotalMoney")!) \(total!) VND"
        }
    }
    let labelTotal: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Thành tiền: 200.000 VND"
        lb.font = Fonts.by(name: .medium, size: 14)
        return lb
    }()
    override func setupView() {
        super.setupView()
        backgroundColor = AppColor.white
        
        addSubview(labelTotal)
        
        labelTotal.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        labelTotal.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
}

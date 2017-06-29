//
//  BankOwnerCell.swift
//  gv24App
//
//  Created by dinhphong on 6/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class BankOwnerCell: BaseCollectionCell{
    let labelWorkDate: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "\(LanguageManager.shared.localized(string: "TheStartDate")! ):"
        lb.font = Fonts.by(name: .light, size: 16)
        return lb
    }()
    
    let labelBank: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "\(LanguageManager.shared.localized(string: "AccountBalance")!) 2.000.000 VND"
        lb.font = Fonts.by(name: .light, size: 16)
        return lb
    }()

    override func setupView() {
        super.setupView()
        backgroundColor = AppColor.white
        
        addSubview(labelWorkDate)
        addSubview(labelBank)
        
        labelWorkDate.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        labelWorkDate.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        labelBank.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        labelBank.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
    }
}

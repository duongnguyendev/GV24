//
//  KeyBillCell.swift
//  gv24App
//
//  Created by dinhphong on 6/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class KeyBillCell: BaseCollectionCell{
   var billId: String?{
        didSet{
            labelKey.text = billId
        }
    }
    private let labelKeyBill: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = UIColor.black
        lb.text = LanguageManager.shared.localized(string: "InvoiceNumber")
        return lb
    }()
    
    private let labelKey: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = UIColor.black
        lb.font = Fonts.by(name: .light, size: 13)
        lb.text = "11111112526536263424762"
        return lb
    }()
    
    let arrowRight : UIImageView = {
        let iv = UIImageView(image: Icon.by(name: .iosArrowRight, color: AppColor.arrowRight))
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func setupView() {
        super.setupView()
        backgroundColor = AppColor.white
        
        addSubview(labelKeyBill)
        addSubview(labelKey)
        addSubview(arrowRight)
        
        labelKeyBill.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        labelKeyBill.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        labelKey.topAnchor.constraint(equalTo: labelKeyBill.bottomAnchor, constant: 5).isActive = true
        labelKey.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        arrowRight.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        arrowRight.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        arrowRight.widthAnchor.constraint(equalToConstant: 20).isActive = true
        arrowRight.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
    }
}

//
//  ApplicantList.swift
//  gv24App
//
//  Created by Macbook Solution on 5/23/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class ApplicantListButton: GeneralButton{
    
    var status: String?{
        didSet{
            labelNumber.text = status
        }
    }
    let labelNumber : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.widthAnchor.constraint(equalToConstant: 20).isActive = true
        lb.heightAnchor.constraint(equalToConstant: 20).isActive = true
        lb.font = Fonts.by(name: .light, size: 15)
        lb.textColor = UIColor.white
        lb.backgroundColor = UIColor.red
        lb.layer.cornerRadius = 10
        lb.layer.masksToBounds = true
        
        lb.textAlignment = .center
        return lb
    }()
    
    override func setupView() {
        super.setupView()
        addSubview(labelNumber)
        labelNumber.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        labelNumber.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
    }
}

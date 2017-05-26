//
//  ApplicantList.swift
//  gv24App
//
//  Created by Macbook Solution on 5/23/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class ApplicantListButton: BaseButton{
    
    var color: UIColor?{
        didSet{
            self.titleView.textColor = color
        }
    }

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
    
    var title: String?{
        didSet{
            titleView.text = LanguageManager.shared.localized(string: title!)
        }
    }
    let titleView: UILabel = {
        let lablel = UILabel()
        lablel.translatesAutoresizingMaskIntoConstraints = false
        lablel.font = Fonts.by(name: .light, size: 16)
        return lablel
    }()
    
    override func setupView() {
        super.setupView()
        addSubview(titleView)
        addSubview(labelNumber)
        
        addConstraintWithFormat(format: "H:|-20-[v0]-10-[v1(20)]-10-|", views: titleView,labelNumber)
        addConstraintWithFormat(format: "V:|-10-[v0]-10-|", views: titleView)
        labelNumber.centerYAnchor.constraint(equalTo: titleView.centerYAnchor, constant: 0).isActive = true
    }
}

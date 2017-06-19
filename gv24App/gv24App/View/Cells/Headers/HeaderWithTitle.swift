//
//  HeaderWithTitle.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/29/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class HeaderWithTitle: BaseHeaderView {

    var title : String?{
        didSet{
            self.labelTitle.text = LanguageManager.shared.localized(string: title!)
        }
    }
    
    private let labelTitle = UILabel()
    override func setupView() {
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelTitle)
        addConstraintWithFormat(format: "H:|-20-[v0]|", views: labelTitle)
        labelTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        labelTitle.textColor = UIColor.gray
        labelTitle.font = Fonts.by(name: .light, size: 15)
    }

}

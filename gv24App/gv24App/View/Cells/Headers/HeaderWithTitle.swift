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
            
        }
    }
    
    private let labelTitle = UILabel()
    override func setupView() {
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(labelTitle)
        addConstraintWithFormat(format: "H:|[v0]|", views: labelTitle)
        labelTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 5).isActive = true
        
        
        
    }

}

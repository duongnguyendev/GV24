//
//  WorkTypeCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 7/20/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class WorkTypeCell: BaseCollectionCell {
    
    var title : String?{
        didSet{
            labelTitle.text = title
        }
    }
    
    private let labelTitle : UILabel = {
        let lb = UILabel()
        lb.text = "Nấu ăn"
        lb.textColor = .white
        lb.font = Fonts.by(name: .medium, size: 10)
        return lb
    }()
    
    private let textBackground : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.rgbAlpha(red: 0, green: 128, blue: 128, alpha: 0.8)
        return v
    }()
    override func setupView() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        addSubview(textBackground)
        addConstraintWithFormat(format: "H:|[v0]|", views: textBackground)
        textBackground.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        textBackground.addSubview(labelTitle)
        
        textBackground.addConstraintWithFormat(format: "H:|-5-[v0]|", views: labelTitle)
        textBackground.addConstraintWithFormat(format: "V:|[v0]|", views: labelTitle)
        
    }

}

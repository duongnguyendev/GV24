//
//  MoreItemCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/4/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class MoreItemCell: BaseMoreCell {

    var text : String?{
        didSet{
            self.labelView.text = LanguageManager.shared.localized(string: text!)
        }
    }
    private let labelView : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .regular, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    override func setupView() {
        super.setupView()
        
        addSubview(labelView)
        labelView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        labelView.leftAnchor.constraint(equalTo: seqaratorView.leftAnchor, constant: 0).isActive = true
        labelView.rightAnchor.constraint(equalTo: arrowRight.leftAnchor, constant: 0).isActive = true
        
    }
}

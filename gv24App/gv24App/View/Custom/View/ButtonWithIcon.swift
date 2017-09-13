//
//  ButtonWithIcon.swift
//  gv24App
//
//  Created by dinhphong on 9/11/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit



class ButtonWithIcon: BaseButton {
    
    
    var bgrColor: UIColor? {
        didSet{
            self.backgroundColor = bgrColor
        }
    }
    
    
    var iconName : UIImage? {
        didSet{
            iconView.image = iconName
        }
    }
    
    
    var title: String? {
        didSet{
            labelTitle.text = title
        }
    }
    
    
    private let iconView : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    
    private let labelTitle: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = AppColor.white
        lb.textAlignment = .center
        lb.font = Fonts.by(name: .medium, size: 16)
        return lb
    }()
    
    override func setupView() {
        super.setupView()
        
        addSubview(iconView)
        addSubview(labelTitle)
        
        iconView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        iconView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        
        labelTitle.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        labelTitle.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
    }

}

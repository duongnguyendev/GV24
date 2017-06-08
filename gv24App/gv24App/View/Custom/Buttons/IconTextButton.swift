//
//  DeleteTaskButton.swift
//  gv24App
//
//  Created by Macbook Solution on 5/23/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
import IoniconsSwift
class IconTextButton: GeneralButton{
    var sizeImage: CGFloat?
    var iconName : Ionicons? {
        didSet{
            iconView.image = Icon.by(name: iconName!, size: sizeImage!, collor: color!)
        }
    }
    private let iconView : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override func setupView() {
        super.setupView()
        addSubview(iconView)
        
        iconView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        iconView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
    }
}

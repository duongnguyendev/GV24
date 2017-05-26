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
class IconTextButton: BaseButton{
    
    var sizeImage: CGFloat?
    var color: UIColor?{
        didSet{
            self.titleView.textColor = color
        }
    }
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
    var title: String?{
        didSet{
            titleView.text = LanguageManager.shared.localized(string: title!)
        }
    }
    let titleView: UILabel = {
        let lablel = UILabel()
        lablel.translatesAutoresizingMaskIntoConstraints = false
        lablel.font = Fonts.by(name: .regular, size: 17)
        return lablel
    }()
    
    override func setupView() {
        super.setupView()
        backgroundColor = UIColor.white
        addSubview(titleView)
        addSubview(iconView)
        
        addConstraintWithFormat(format: "H:|-20-[v0]-10-[v1]-5-|", views: titleView,iconView)
        addConstraintWithFormat(format: "V:|-10-[v0]-10-|", views: titleView)
        
        iconView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor, constant: 0).isActive = true
    }
}

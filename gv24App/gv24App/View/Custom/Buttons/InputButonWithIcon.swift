//
//  InputButonWithIcon.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/7/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import IoniconsSwift

class InputButonWithIcon: BaseButton {
    
    var hideBottomLine : Bool?{
        didSet{
            bottomLine.isHidden = hideBottomLine!
        }
    }

    var color: UIColor = AppColor.backButton{
        didSet{
            self.titleView.textColor = color
        }
    }
    var iconName : Ionicons? {
        didSet{
            iconView.image = Icon.by(name: iconName!, color: color)
        }
    }
    var titleFont : UIFont?{
        didSet{
            titleView.font = titleFont
        }
    }
    private let iconView = IconView(size: 15)
    private let bottomLine = UIView.horizontalLine()
    
    var title: String?{
        didSet{
            titleView.text = LanguageManager.shared.localized(string: title!)
        }
    }
    let titleView: UILabel = {
        let lablel = UILabel()
        lablel.translatesAutoresizingMaskIntoConstraints = false
        lablel.font = Fonts.by(name: .regular, size: 15)
        return lablel
    }()
    
    override func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconView)
        addSubview(titleView)
        addSubview(bottomLine)
        
        addConstraintWithFormat(format: "H:|[v0]-10-[v1]|", views: iconView, titleView)
        titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        titleView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        iconView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        bottomLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        bottomLine.leftAnchor.constraint(equalTo: titleView.leftAnchor, constant: 0).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
}

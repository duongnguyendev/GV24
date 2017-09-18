//
//  HomeFunctButton.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/3/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import IoniconsSwift
import AlamofireImage


class HomeFunctButton: BaseButton {
    
    var iconName : Ionicons? {
        didSet{
            iconView.image = Icon.by(name: iconName!, size: 50, collor: UIColor.white)
        }
    }
    var imageName : String?{
        didSet{
            iconView.image = UIImage(named: imageName!)
        }
    }
    var title: String?{
        didSet{
            self.titleView.text = LanguageManager.shared.localized(string: title!)
        }
    }
    var textColor: UIColor? {
        didSet{
            titleView.textColor = textColor
        }
    }
    var iconUrl : String?{
        didSet{
            guard let icon = iconUrl else {
                return
            }
            guard let url = URL(string: icon) else {
                return
            }

            iconView.af_setImage(withURL: url, placeholderImage: nil)
        }
    }
    private let iconView : CustomImageView = {
        let iv = CustomImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private let titleView : UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .center
        lb.font = Fonts.by(name: .medium, size: 16)
        lb.textColor = UIColor.white
        return lb
    }()
    
    override func setupView() {
        addSubview(iconView)
        addSubview(titleView)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: iconView)
        addConstraintWithFormat(format: "H:|-3-[v0]-3-|", views: titleView)
        addConstraintWithFormat(format: "V:|-5-[v0][v1]-5-|", views: iconView, titleView)
        
        self.addConstraint(NSLayoutConstraint(item: iconView, attribute: .height, relatedBy: .equal, toItem: titleView, attribute: .height, multiplier: 1, constant: 0))
    }
    
    
}

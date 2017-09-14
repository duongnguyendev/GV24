//
//  GeneralButton.swift
//  gv24App
//
//  Created by Macbook Solution on 6/7/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class GeneralButton: BaseButton{
    var color: UIColor?{
        didSet{
            self.titleView.textColor = color
        }
    }
    var title: String?{
        didSet{
            titleView.text = LanguageManager.shared.localized(string: title!)
        }
    }
    
    var titleView: UILabel = {
        var lablel = UILabel()
        lablel.translatesAutoresizingMaskIntoConstraints = false
        lablel.font = Fonts.by(name: .light, size: 16)
        lablel.textAlignment = .center
        lablel.textColor = AppColor.white
        return lablel
    }()
    
    override func setupView() {
        super.setupView()
        addSubview(titleView)
        
        addConstraintWithFormat(format: "H:|-10-[v0]|", views: titleView)
        addConstraintWithFormat(format: "V:|-10-[v0]-10-|", views: titleView)
    }
    
}

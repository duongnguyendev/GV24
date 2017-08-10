//
//  AbilityCell.swift
//  gv24App
//
//  Created by dinhphong on 6/20/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class AbilityCell: BaseCollectionCell {
    
    let abilityView : HomeFunctButton = {
        let bt = HomeFunctButton()
        bt.backgroundColor = UIColor.clear
        bt.imageName = "nau_an"
        bt.title = "Tài khoản\nGv24"
        bt.textColor = .black
        return bt
    }()

    override func setupView() {
        super.setupView()
        addSubview(abilityView)
        addConstraintWithFormat(format: "H:|-5-[v0]-5-|", views: abilityView)
        addConstraintWithFormat(format: "V:|-5-[v0]-5-|", views: abilityView)
    }
    
    var ability: Ability?{
        didSet{
//            abilityView.imageView?.loadImageurl(link: (ability?.image)!)
            abilityView.iconUrl = ability?.image
            abilityView.title = ability?.name
        }
    }
    
}

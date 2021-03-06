//
//  CheckBook.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/2/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import IoniconsSwift

class CheckBox: BaseButton {

    var title: String?{
        didSet{
            titleView.text = title
            let size = CGSize(width: 1000, height: 30)
            let titleWidth = title?.widthWith(size: size, font: Fonts.by(name: .light, size: 15))
            self.width = titleWidth! + 15 + 15
        }
    }
    var width : CGFloat?
    override var isSelected: Bool{
        didSet{
            if isSelected{
                statusIcon.image = Icon.by(name: .androidCheckboxOutline, color: AppColor.backButton)
            }else{
                statusIcon.image = Icon.by(name: .androidCheckboxOutlineBlank, color: AppColor.backButton)
            }
        }
    }
    
    let statusIcon : IconView = {
        let icon = IconView(icon: Ionicons.androidCheckboxOutlineBlank, size: 20, color: AppColor.backButton)
        return icon
    }()
    let titleView : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.by(name: .light, size: 15)
        label.numberOfLines = 0
        return label
    }()
    override func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(statusIcon)
        addSubview(titleView)
        
        titleView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleView.leftAnchor.constraint(equalTo: self.statusIcon.rightAnchor, constant: 10).isActive = true
        titleView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        statusIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        statusIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
    }
}

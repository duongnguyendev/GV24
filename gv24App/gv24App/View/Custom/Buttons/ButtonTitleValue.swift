//
//  ButtonTitleValue.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/2/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class ButtonTitleValue: BaseButton {

    var title : String?{
        didSet{
            labelTitle.text = title
        }
    }
    var valueString : String?{
        didSet{
            labelValue.text = valueString
        }
    }
    var showBottomLine : Bool?{
        didSet{
            if showBottomLine == true {
                bottomLine.isHidden = false
            }else{
                bottomLine.isHidden = true
            }
        }
    }
    
    let labelTitle : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let labelValue : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .regular, size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = AppColor.backButton
        return lb
    }()
    private let bottomLine : UIView = {
        let view = UIView.horizontalLine()
        view.isHidden = true
        return view
    }()
    
    override func setupView() {
        addSubview(labelTitle)
        addSubview(labelValue)
        addSubview(bottomLine)
        
        labelTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        labelTitle.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        
        labelValue.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        labelValue.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        
        bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        bottomLine.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        bottomLine.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
    }

}

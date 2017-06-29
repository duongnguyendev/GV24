//
//  DescInfoView.swift
//  gv24App
//
//  Created by Macbook Solution on 5/25/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
import IoniconsSwift
class DescInfoView: BaseView{
    let margin : CGFloat = 10
    var icon : Ionicons? {
        didSet{
            iconType.image = Icon.by(name: icon!, size: 20, collor: AppColor.backButton)
        }
    }
    var name : String? {
        didSet{
            labelName.text = name
        }
    }
    let iconType: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    let labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.font = Fonts.by(name: .light, size: 15)
        return label
    }()
    let viewLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgb(red: 200, green: 199, blue: 204)
        
        return view
    }()
    
    override func setupView() {
        super.setupView()
        backgroundColor = UIColor.white
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconType)
        addSubview(labelName)
        
        iconType.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        iconType.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        
        labelName.leftAnchor.constraint(equalTo: iconType.rightAnchor, constant: 10).isActive = true
        labelName.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
    
}

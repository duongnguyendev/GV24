//
//  JobTypeCell.swift
//  gv24App
//
//  Created by dinhphong on 6/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class JobTypeCell: BaseCollectionCell{
    
    let margin: CGFloat = 20
    var task: Task? {
        didSet{
            iconType.loadImageurl(link: (task?.info?.work?.image)!)
            labelTitle.text = task?.info?.title
            labelType.text = task?.info?.work?.name
        }
    }
    
    private let iconType : IconView = {
        let iv = IconView(image: "nau_an", size: 50)
        return iv
    }()
    private let labelTitle : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .medium, size: 17)
        lb.text = "Lau dọn nhà"
        return lb
    }()
    
    private let labelType : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 12)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Dọn dẹp nhà cửa"
        lb.textColor = UIColor.gray
        return lb
    }()

    override func setupView() {
        super.setupView()
        backgroundColor = AppColor.white
        
        addSubview(iconType)
        addSubview(labelTitle)
        addSubview(labelType)
        
        iconType.topAnchor.constraint(equalTo: topAnchor, constant: margin/2).isActive = true
        iconType.leftAnchor.constraint(equalTo: leftAnchor, constant: margin/2).isActive = true
        
        labelTitle.topAnchor.constraint(equalTo: iconType.topAnchor, constant: margin/2).isActive = true
        labelTitle.leftAnchor.constraint(equalTo: iconType.rightAnchor, constant: margin/2).isActive = true
        labelTitle.rightAnchor.constraint(equalTo: rightAnchor, constant: -margin).isActive = true
        
        labelType.leftAnchor.constraint(equalTo: iconType.rightAnchor, constant: margin/2).isActive = true
        labelType.bottomAnchor.constraint(equalTo: iconType.bottomAnchor, constant: -margin/4).isActive = true
    }
    
    
}

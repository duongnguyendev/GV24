//
//  NavigationButton.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/3/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit

class BackButton: BaseButton {
    private let iconImageView : UIImageView = {
        let iv = UIImageView(image: Icon.by(name: .iosArrowBack, color: AppColor.backButton))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private let titleView : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .regular, size: 16)
        lb.text = LanguageManager.shared.localized(string: "Back")
        lb.textColor = AppColor.backButton
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    override func setupView() {
        addSubview(iconImageView)
        addSubview(titleView)
        
        iconImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 12).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        titleView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleView.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: -8).isActive = true
    }
}
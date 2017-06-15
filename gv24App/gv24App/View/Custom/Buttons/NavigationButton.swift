//
//  NavigationButton.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/3/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
import IoniconsSwift

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
        lb.textColor = AppColor.backButton
        lb.text = LanguageManager.shared.localized(string: "Back")
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

class NavButton: BaseButton{
    init(title : String) {
        super.init(frame: CGRect(x: 0, y: 0, width: 70, height: 20))
        self.titleLabel?.font = Fonts.by(name: .regular, size: 16)
        self.contentHorizontalAlignment = .right
        self.setTitle(LanguageManager.shared.localized(string: title), for: .normal)
        self.setTitleColor(AppColor.backButton, for: .normal)
    }
    init(icon: Ionicons) {
        super.init(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        self.setBackgroundImage(Icon.by(name: icon, color: AppColor.backButton), for: .normal)
    }
    init(title: String, frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = Fonts.by(name: .regular, size: 16)
        self.setTitle(title, for: .normal)
        self.setTitleColor(AppColor.backButton, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




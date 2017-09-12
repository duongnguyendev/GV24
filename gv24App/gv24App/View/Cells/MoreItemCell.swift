//
//  MoreItemCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/4/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import IoniconsSwift

class MoreItemCell: BaseMoreCell {
    
    var text : String?{
        didSet{
            self.labelView.text = LanguageManager.shared.localized(string: text!)

        }
    }
    
    let labelView : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .regular, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    
    override func setupView() {
        super.setupView()
        addSubview(labelView)
        labelView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        labelView.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 5).isActive = true
    }
}


protocol LogoutCellDelegate: class {
    func logout(cell: LogoutCell)
}

class LogoutCell : MoreItemCell{

    weak var delegate: LogoutCellDelegate?
    
    var titleLogout : String?{
        didSet{
            self.btLogOut.setTitle(LanguageManager.shared.localized(string: titleLogout!), for: .normal)
            
        }
    }
    
    lazy var btLogOut: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = AppColor.colorButtonLogout
        btn.layer.cornerRadius = 4
        btn.addTarget(self, action: #selector(signOut(_:)), for: .touchUpInside)
        btn.setTitle("Logout", for: .normal)
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        btn.tintColor = AppColor.titleButtonLogout
        return btn
    }()
    
    func signOut(_ sender: UIButton) {
      delegate?.logout(cell: self)
    }
    
    override func setupView() {
        super.setupView()
        self.backgroundColor = AppColor.white
        self.contentView.addSubview(btLogOut)
        
        contentView.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: btLogOut)
        contentView.addConstraintWithFormat(format: "V:|[v0]|", views: btLogOut)
        
    }
}

class MoreSocialCell: BaseMoreCell{
    var text : String?{
        didSet{
            self.labelView.text = LanguageManager.shared.localized(string: text!)
        }
    }

     var icon: Ionicons?{
        didSet{
            iconView.image = Icon.by(name: icon!, color: AppColor.backButton)
        }
    }
    private let iconView : IconView = {
        let iv = IconView(size: 25)
        return iv
    }()
    let labelView : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .regular, size: 16)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = AppColor.backButton
        return lb
    }()
    override func setupView() {
        
        super.setupView()
        //addSubview(iconView)
        addSubview(labelView)
        
        //iconView.leftAnchor.constraint(equalTo: seqaratorView.leftAnchor, constant: 0).isActive = true
        //addConstraintWithFormat(format: "H:[v0]-10-[v1]", views: iconView, labelView)
        labelView.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 5).isActive = true
        labelView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        labelView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
}

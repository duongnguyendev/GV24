//
//  ComboBox.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/2/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import IoniconsSwift

class RadioButton: BaseButton, UITextFieldDelegate {
    
    var showBottomLine : Bool?{
        didSet{
            if showBottomLine! {
                bottomLine.isHidden = false
            }
            else{
                bottomLine.isHidden = true
            }
        }
    }
    
    var unit : String?{
        didSet{
            labelUnit.isHidden = false
            labelUnit.text = unit
        }
    }
    
    var title: String?{
        didSet{
            let str = NSAttributedString(string: title!, attributes: [NSForegroundColorAttributeName:UIColor.black])
            titleView.attributedPlaceholder = str
        }
    }
    private var bottomLine :UIView = {
        let view = UIView.horizontalLine()
        view.isHidden = true
        return view
    }()
    
    override var isSelected: Bool{
        didSet{
            if isSelected{
                statusIcon.image = Icon.by(name: .androidRadioButtonOn, color: AppColor.backButton)
            }else{
                statusIcon.image = Icon.by(name: .androidRadioButtonOff, color: AppColor.backButton)
            }
        }
    }
    
    let statusIcon : IconView = {
        let icon = IconView(icon: Ionicons.androidRadioButtonOff, size: 15, color: AppColor.backButton)
        return icon
    }()
    lazy var titleView : UITextField = {
        let label = UITextField()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isEnabled = false
        label.font = Fonts.by(name: .light, size: 15)
        label.keyboardType = .numberPad
        label.delegate = self
        return label
    }()
    
    private let labelUnit : UILabel = {
        let lb = UILabel()
        lb.isHidden = true
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = AppColor.lightGray
        lb.font = Fonts.by(name: .regular, size: 15)
        lb.textAlignment = .right
        return lb
    }()
    override func setupView() {
        
        addSubview(statusIcon)
        addSubview(titleView)
        addSubview(bottomLine)
        addSubview(labelUnit)
        
        titleView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        titleView.leftAnchor.constraint(equalTo: self.statusIcon.rightAnchor, constant: 10).isActive = true
        titleView.rightAnchor.constraint(equalTo: labelUnit.leftAnchor, constant: 0).isActive = true
        statusIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        statusIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        
        labelUnit.widthAnchor.constraint(equalToConstant: 50).isActive = true
        labelUnit.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelUnit.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        
        bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        bottomLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        bottomLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        
        
        
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == ""{
            return true
        }
        else{
            if (Int(string) != nil){
                return true
            }
        }
        return false
    }
}

//
//  SwitchCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/25/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
@objc protocol SwitchCellDelegate{
    @objc optional func notification(isOn : Bool)
}
class SwitchCell: BaseMoreCell {
    
    weak var delegate : SwitchCellDelegate?{
        didSet{
            self.switchView.isOn = UserHelpers.notificationIsAvailble
        }
    }
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
    
    private let switchView : UISwitch = {
        let sv = UISwitch()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    

    override func setupView() {
        super.setupView()
        backgroundColor = AppColor.white
        addSubview(switchView)
        addSubview(labelView)
        switchView.addTarget(self, action: #selector(swithchChangeValue(_:)), for: .valueChanged)
        switchView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        switchView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        
        labelView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        labelView.leftAnchor.constraint(equalTo: self.iconImage.rightAnchor, constant: 10).isActive = true
        labelView.rightAnchor.constraint(equalTo: self.switchView.leftAnchor, constant: 10).isActive = true
        
        setupSeqaratorView()
        
    }
    
    func swithchChangeValue(_ sender : UISwitch){
        self.delegate?.notification!(isOn: sender.isOn)
    }
    func setupSeqaratorView(){
        let view = UIView.horizontalLine()
        addSubview(view)
        view.backgroundColor = AppColor.seqaratorView
        
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        view.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        view.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }

}

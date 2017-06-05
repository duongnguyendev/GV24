//
//  DateLauncher.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

@objc protocol DateTimeLauncherDelegate{
    @objc optional func selected(dateTime: Date, for sender : UIButton)
}

class DateLauncher: BaseLauncher {
    
    var delegate : DateTimeLauncherDelegate?
    var pickerMode : UIDatePickerMode?{
        didSet{
            datePicker.datePickerMode = pickerMode!
        }
    }
    var sender : UIButton?
    
    let datePicker : UIDatePicker = {
        let picker = UIDatePicker()
        picker.date = Date()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    override func setupContent() {
        super.setupContent()
        contentView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    override func setupComponent() {
        super.setupComponent()
        contentView.addSubview(datePicker)
        datePicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        datePicker.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0).isActive = true
        datePicker.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: buttonOK.topAnchor, constant: 0).isActive = true
    }
    override func handleButtonOK(_ sender: UIButton) {
        if delegate != nil {
            self.delegate?.selected!(dateTime: datePicker.date, for: self.sender!)
        }
        
        super.handleButtonOK(sender)
    }
}

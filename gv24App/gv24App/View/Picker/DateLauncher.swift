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
    var startDate : Date?{
        didSet{
            datePicker.date = startDate!
        }
    }
    let datePicker : UIDatePicker = {
        let picker = UIDatePicker()
        if LanguageManager.shared.getCurrentLanguage().languageCode == "vi" {
            picker.locale = Locale.init(identifier: "vi")
        }
        picker.date = Date()
        let calendar = Calendar(identifier: .gregorian)
        picker.minimumDate = Date()
        let currentYear = Int(Date().year)
        picker.maximumDate = Date(year: (currentYear! + 5))
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    override func setupMainView() {
        super.setupMainView()
        mainView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    override func addContentView() {
        super.addContentView()
        mainView.addSubview(datePicker)
        datePicker.locale = Locale(identifier: LanguageManager.shared.getCurrentLanguage().languageCode!)
    }
    override func setupSubView() {
        super.setupSubView()
        datePicker.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0).isActive = true
        datePicker.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 0).isActive = true
        datePicker.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 0).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: buttonOK.topAnchor, constant: 0).isActive = true
    }
    override func handleButtonOK(_ sender: UIButton) {
        if delegate != nil {
            self.delegate?.selected!(dateTime: datePicker.date, for: self.sender!)
        }
        
        super.handleButtonOK(sender)
    }
}

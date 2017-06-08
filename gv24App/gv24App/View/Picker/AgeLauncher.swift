//
//  AgeLauncher.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/7/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import IoniconsSwift

@objc protocol AgeLauncherDelegate{
    @objc optional func select(age : Int , toAge : Int)
}

class AgeLauncher: BaseLauncher, UIPickerViewDelegate, UIPickerViewDataSource {

    var delegate : AgeLauncherDelegate?
    
    var ageTo : Int =  60{
        didSet{
            if ageTo < ageFrom{
                ageFromPicker.selectRow(0, inComponent: 0, animated: true)
            }
        }
    }
    var ageFrom : Int = 18{
        didSet{
            if ageFrom > ageTo{
                ageToPicker.selectRow(ageList.count - 1, inComponent: 0, animated: true)
            }
        }
    }
    
    lazy var ageFromPicker : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    
    lazy var ageToPicker : UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
        return pickerView
    }()
    let buttonCancel : BasicButton = {
        let btn = BasicButton()
        btn.titleCollor = AppColor.white
        btn.color = AppColor.homeButton1
        btn.title = "Cancel"
        return btn
    }()
    let ageList : [Int] = [18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60]
    let lineIcon = IconView(icon: Ionicons.minus, size: 15, color: AppColor.homeButton1)
    
    override func setupMainView() {
        super.setupMainView()
        mainView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    override func addContentView() {
        super.addContentView()
        mainView.addSubview(buttonCancel)
        mainView.addSubview(ageFromPicker)
        mainView.addSubview(ageToPicker)
        mainView.addSubview(lineIcon)
        
    }
    override func setupButton() {
        buttonOK.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonCancel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        buttonOK.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true
        buttonCancel.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0).isActive = true
        
        buttonCancel.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 0).isActive = true
        buttonOK.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 0).isActive = true
        
        mainView.addConstraint(NSLayoutConstraint(item: buttonCancel, attribute: .width, relatedBy: .equal, toItem: buttonOK, attribute: .width, multiplier: 1, constant: 0))
        buttonCancel.rightAnchor.constraint(equalTo: buttonOK.leftAnchor, constant: 0).isActive = true
        buttonCancel.addTarget(self, action: #selector(handleButtonCancel(_:)), for: .touchUpInside)
        buttonOK.addTarget(self, action: #selector(handleButtonOK(_:)), for: .touchUpInside)
    }
    override func setupSubView() {
        super.setupSubView()
        
        lineIcon.centerXAnchor.constraint(equalTo: mainView.centerXAnchor, constant: 0).isActive = true
        lineIcon.centerYAnchor.constraint(equalTo: ageToPicker.centerYAnchor, constant: 0).isActive = true
        
        ageFromPicker.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0).isActive = true
        ageFromPicker.leftAnchor.constraint(equalTo: mainView.leftAnchor, constant: 0).isActive = true
        ageFromPicker.rightAnchor.constraint(equalTo: lineIcon.leftAnchor, constant: 0).isActive = true
        ageFromPicker.bottomAnchor.constraint(equalTo: buttonCancel.topAnchor, constant: 0).isActive = true
        
        ageToPicker.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 0).isActive = true
        ageToPicker.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: 0).isActive = true
        ageToPicker.leftAnchor.constraint(equalTo: lineIcon.rightAnchor, constant: 0).isActive = true
        ageToPicker.bottomAnchor.constraint(equalTo: buttonCancel.topAnchor, constant: 0).isActive = true
        
        ageFromPicker.selectRow(0, inComponent: 0, animated: true)
        ageToPicker.selectRow(ageList.count - 1, inComponent: 0, animated: true)
    }
    
    override func handleButtonOK(_ sender: UIButton) {
        self.delegate?.select!(age: ageFrom, toAge: ageTo)
        
        super.handleButtonOK(sender)
    }
    
    func handleButtonCancel(_ sender : UIButton){
        self.close()
    }
    
    //MARK: - Picker delegate
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ageList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(ageList[row])"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == ageFromPicker {
            ageFrom = ageList[ageFromPicker.selectedRow(inComponent: 0)]
        }else{
            ageTo = ageList[ageToPicker.selectedRow(inComponent: 0)]
        }
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0
    }
}

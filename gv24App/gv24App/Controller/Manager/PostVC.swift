//
//  PostVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class PostVC: BaseVC, DateTimeLauncherDelegate {

    var date : Date? = Date(){
        didSet{
            buttonDate.valueString = date?.dayMonthYear
        }
    }
    var timeStart : Date? = Date(){
        didSet{
            buttonFrom.title = timeStart?.hourMinute
        }
    }
    var timeEnd : Date? = Date(){
        didSet{
            buttonTo.title = timeStart?.hourMinute
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.collection
        hideKeyboardWhenTouchUpOutSize = true
        title = "Đăng công việc"
    }
    
    
    override func setupRightNavButton() {
        let buttonSend = NavButton(title: "Đăng bài")
        buttonSend.addTarget(self, action: #selector(handlePostButton(_:)), for: .touchUpInside)
        let btn = UIBarButtonItem(customView: buttonSend)
        self.navigationItem.rightBarButtonItem = btn
    }
    let mainScrollView : UIScrollView = UIScrollView()
    let mainView : UIView = UIView()
    
    let infoView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    let typeView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let timeView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleTextField : UITextFieldButtomLine = {
        let tF = UITextFieldButtomLine()
        tF.font = Fonts.by(name: .light, size: 15)
        tF.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tF.placeholder = "Tiêu đề"
        return tF
    }()
    let typeTextField : UITextFieldButtomLine = {
        let tF = UITextFieldButtomLine()
        tF.font = Fonts.by(name: .light, size: 15)
        tF.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tF.placeholder = "Loại công việc"
        return tF
    }()
    let descriptionTextField : UITextFieldButtomLine = {
        let tF = UITextFieldButtomLine()
        tF.font = Fonts.by(name: .light, size: 15)
        tF.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tF.placeholder = "Mô tả công việc"
        return tF
    }()
    let addressTextField : UITextFieldButtomLine = {
        let tF = UITextFieldButtomLine()
        tF.font = Fonts.by(name: .light, size: 15)
        tF.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tF.placeholder = "Địa chỉ làm việc"
        return tF
    }()
    let checkBoxTool : CheckBox = {
        let cb = CheckBox()
        cb.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cb.addTarget(self, action: #selector(handleCheckBoxToolButton(_:)), for: .touchUpInside)
        cb.title = "Mang theo dụng cụ làm việc"
        return cb
    }()
    let radioButtonMoney : RadioButton = {
        let rb = RadioButton()
        rb.showBottomLine = true
        rb.title = "Nhập số tiền công"
        rb.addTarget(self, action: #selector(handleRadioButton(_:)), for: .touchUpInside)
        rb.isSelected = true
        return rb
    }()
    let radioButtonTime : RadioButton = {
        let rb = RadioButton()
        rb.title = "Khoán theo thời gian"
        rb.addTarget(self, action: #selector(handleRadioButton(_:)), for: .touchUpInside)
        return rb
    }()
    
    let buttonDate : ButtonTitleValue = {
        let btn = ButtonTitleValue()
        btn.title = "Ngày làm việc"
        btn.valueString = Date().dayMonthYear
        btn.showBottomLine = true
        btn.addTarget(self, action: #selector(handleButtonDate(_:)), for: .touchUpInside)
        return btn
    }()
    
    let buttonFrom: BasicButton = {
        let btn = BasicButton()
        btn.titleCollor = AppColor.backButton
        btn.title = Date().hourMinute
        btn.contentHorizontalAlignment = .left
        btn.addTarget(self, action: #selector(handleButtonFrom(_:)), for: .touchUpInside)
        return btn
    }()
    
    let buttonTo: BasicButton = {
        let btn = BasicButton()
        btn.titleCollor = AppColor.backButton
        btn.title = Date().hourMinute
        btn.contentHorizontalAlignment = .right
        btn.addTarget(self, action: #selector(handleButtonTo(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy var dateLauncher : DateLauncher = {
        let launcher = DateLauncher()
        launcher.delegate = self
        return launcher
    }()
    
    override func setupView() {
        setupMainView()
        setupSubView()
        setupInfoView()
        setupTypeView()
        setupTimeView()
    }
    
    private func setupMainView(){
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainView)
        
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        mainView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 0).isActive = true
        mainView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor, constant: 0).isActive = true
        mainView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor, constant: 0).isActive = true
        mainView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: 0).isActive = true
        
        mainView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
    }
    
    func setupSubView(){
        mainView.addSubview(infoView)
        mainView.addSubview(typeView)
        mainView.addSubview(timeView)
        
        mainView.addConstraintWithFormat(format: "V:|-20-[v0(200)]-20-[v1(100)]-20-[v2(120)]|", views: infoView, typeView, timeView)
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: infoView)
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views:  typeView)
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: timeView)
    }
    
    func setupInfoView(){
        infoView.addSubview(titleTextField)
        infoView.addSubview(typeTextField)
        infoView.addSubview(descriptionTextField)
        infoView.addSubview(addressTextField)
        infoView.addSubview(checkBoxTool)
        
        infoView.addConstraintWithFormat(format: "V:|[v0][v1][v2][v3][v4]", views: titleTextField, typeTextField, descriptionTextField, addressTextField, checkBoxTool)
        mainView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: titleTextField)
        mainView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: typeTextField)
        mainView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: descriptionTextField)
        mainView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: addressTextField)
        mainView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: checkBoxTool)
        
        
    }
    func setupTypeView(){
        typeView.addSubview(radioButtonTime)
        typeView.addSubview(radioButtonMoney)
        
        typeView.addConstraintWithFormat(format: "V:|[v0][v1]|", views: radioButtonMoney, radioButtonTime)
        typeView.addConstraint(NSLayoutConstraint(item: radioButtonMoney, attribute: .height, relatedBy: .equal, toItem: radioButtonTime, attribute: .height, multiplier: 1, constant: 0))
        
        typeView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: radioButtonTime)
        typeView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: radioButtonMoney)
    }
    func setupTimeView(){
        timeView.addSubview(buttonDate)
        
        buttonDate.topAnchor.constraint(equalTo: timeView.topAnchor, constant: 0).isActive = true
        buttonDate.heightAnchor.constraint(equalToConstant: 40).isActive = true
        timeView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: buttonDate)
        
        let labelTime = UILabel()
        labelTime.font = Fonts.by(name: .light, size: 15)
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        labelTime.text = "Thời gian làm việc"
        
        let labelTo = UILabel()
        labelTo.font = Fonts.by(name: .light, size: 15)
        labelTo.translatesAutoresizingMaskIntoConstraints = false
        labelTo.text = "đến"
        timeView.addSubview(labelTime)
        timeView.addSubview(labelTo)
        
        labelTime.topAnchor.constraint(equalTo: buttonDate.bottomAnchor, constant: 10).isActive = true
        labelTime.leftAnchor.constraint(equalTo: timeView.leftAnchor, constant: 30).isActive = true
        
        labelTo.bottomAnchor.constraint(equalTo: timeView.bottomAnchor, constant: -10).isActive = true
        labelTo.centerXAnchor.constraint(equalTo: timeView.centerXAnchor, constant: 0).isActive = true
        
        timeView.addSubview(buttonFrom)
        timeView.addSubview(buttonTo)
        
        buttonFrom.leftAnchor.constraint(equalTo: timeView.leftAnchor, constant: 30).isActive = true
        buttonFrom.rightAnchor.constraint(equalTo: labelTo.leftAnchor, constant: 0).isActive = true
        buttonFrom.centerYAnchor.constraint(equalTo: labelTo.centerYAnchor, constant: 0).isActive = true
        buttonFrom.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        buttonTo.rightAnchor.constraint(equalTo: timeView.rightAnchor, constant: -30).isActive = true
        buttonTo.leftAnchor.constraint(equalTo: labelTo.rightAnchor, constant: 0).isActive = true
        buttonTo.centerYAnchor.constraint(equalTo: labelTo.centerYAnchor, constant: 0).isActive = true
        buttonTo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
    func handleCheckBoxToolButton(_ sender: UIButton){
        if checkBoxTool.isSelected{
            checkBoxTool.isSelected = false
        }else{
            checkBoxTool.isSelected = true
        }
    }
    
    func handleRadioButton(_ sender: RadioButton){
        if sender == radioButtonTime {
            radioButtonTime.isSelected = true
            radioButtonMoney.isSelected = false
            radioButtonMoney.titleView.isEnabled = false
            radioButtonMoney.title = radioButtonMoney.title
            
        }else{
            radioButtonMoney.isSelected = true
            radioButtonTime.isSelected = false
            radioButtonMoney.titleView.isEnabled = true
            radioButtonMoney.titleView.becomeFirstResponder()
        }
    }
    
    func selected(dateTime: Date, for sender: UIButton) {
        switch sender {
        case buttonDate:
            date = dateTime
            break
        case buttonFrom:
            timeStart = dateTime
            break
        case buttonTo:
            timeEnd = dateTime
            break
        default:
            break
        }
    }
    
    func handleButtonDate(_ sender : UIButton){
        showDatePickerWith(mode: .date, sender: sender)
    }
    func handleButtonTime(_ sender: UIButton){
        print("handleButtonTime")
    }
    
    func handlePostButton(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    func handleButtonFrom(_ sender: UIButton){
        showDatePickerWith(mode: .time, sender: sender)
    }
    func handleButtonTo(_ sender: UIButton){
        showDatePickerWith(mode: .time, sender: sender)
    }
    
    func showDatePickerWith(mode : UIDatePickerMode, sender : UIButton){
        dateLauncher.pickerMode = mode
        dateLauncher.sender = sender
        dateLauncher.show()
    }
}

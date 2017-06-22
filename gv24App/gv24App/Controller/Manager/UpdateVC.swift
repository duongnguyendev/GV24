//
//  UpdateVC.swift
//  gv24App
//
//  Created by dinhphong on 6/21/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class UpdateVC: BaseVC, DateTimeLauncherDelegate, UITextFieldDelegate{
    var task = Task()
    var date : Date? = Date(){
        didSet{
            buttonDate.valueString = date?.dayMonthYear
            timeStart = date
            timeEnd = date
        }
    }
    var timeStart : Date? = Date(){
        didSet{
            buttonFrom.title = timeStart?.hourMinute
        }
    }
    var timeEnd : Date? = Date(){
        didSet{
            buttonTo.title = timeEnd?.hourMinute
        }
    }
    var workType : WorkType?{
        didSet{
            typeTextField.text = workType?.name
        }
    }
    
    var workTypes : [WorkType]?
    var params = Dictionary<String, Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.collection
        hideKeyboardWhenTouchUpOutSize = true
        title = "Chỉnh sửa công việc"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.titleTextField.text = task.info?.title
        self.workType = task.info?.work
        self.descriptionTextField.text = task.info?.desc
        self.addressTextField.text = task.info?.address?.name
        self.checkBoxTool.isSelected = (task.info?.tool)!
        if task.info?.package?.id == "000000000000000000000001"{
            radioButtonMoney.titleView.text = "\((task.info?.price)!)"
            radioButtonMoney.isSelected = true
            radioButtonTime.isSelected = false
        }else{
            radioButtonTime.isSelected = true
            radioButtonMoney.isSelected = false
        }
        self.timeStart = Date(isoDateString: (task.info?.time?.startAt)!)
        self.buttonFrom.title = timeStart?.hourMinute
        self.timeEnd = Date(isoDateString: (task.info?.time?.endAt)!)
        self.buttonTo.title = timeEnd?.hourMinute
    }
    
    override func setupRightNavButton() {
        let buttonSend = NavButton(title: "Sửa bài")
        buttonSend.addTarget(self, action: #selector(handleUpdateButton(_:)), for: .touchUpInside)
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
    lazy var descriptionTextField : UITextFieldButtomLine = {
        let tF = UITextFieldButtomLine()
        tF.font = Fonts.by(name: .light, size: 15)
        tF.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tF.placeholder = "Mô tả công việc"
        tF.delegate = self
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
        rb.unit = "VND"
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
    let buttonWorkTypes : UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handleButtonWorkTypes(_:)), for: .touchUpInside)
        return btn
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
        infoView.addSubview(buttonWorkTypes)
        
        
        infoView.addConstraintWithFormat(format: "V:|[v0][v1][v2][v3][v4]", views: titleTextField, typeTextField, descriptionTextField, addressTextField, checkBoxTool)
        mainView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: titleTextField)
        mainView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: typeTextField)
        mainView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: descriptionTextField)
        mainView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: addressTextField)
        mainView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: checkBoxTool)
        
        buttonWorkTypes.topAnchor.constraint(equalTo: typeTextField.topAnchor, constant: 0).isActive = true
        buttonWorkTypes.leftAnchor.constraint(equalTo: typeTextField.leftAnchor, constant: 0).isActive = true
        buttonWorkTypes.rightAnchor.constraint(equalTo: typeTextField.rightAnchor, constant: 0).isActive = true
        buttonWorkTypes.bottomAnchor.constraint(equalTo: typeTextField.bottomAnchor, constant: 0).isActive = true
        
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
        labelTo.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
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
    
    //MARK: - handle button
    
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
    
    func handleButtonDate(_ sender : UIButton){
        showDatePickerWith(mode: .date, sender: sender)
    }
    func handleButtonWorkTypes(_ sender: UIButton){
        if self.workTypes == nil{
            TaskService.shared.getWorkTypes { (workTypes, error) in
                if error == nil{
                    self.workTypes = workTypes
                    self.handleActionSheet()
                }
            }
        }else{
            handleActionSheet()
        }
    }
    
    func handleUpdateButton(_ sender: UIButton){
        validate { (errorString) in
            if errorString == nil{
                self.params["tools"] = self.checkBoxTool.isSelected
                self.params["id"] = self.task.id
                self.params["process"] = self.task.process?.id
                TaskService.shared.updateTask(params: self.params) { (error) in
                    if error == nil{
                        self.showAlertWith(message: "Chỉnh sửa thành công", completion: {
                            self.dismiss(animated: true, completion: nil)
                        })
                    }else{
                        self.showAlertWith(message: error!, completion: {})
                    }
                }
            }
            else{
                self.showAlertWith(message: errorString!, completion: {})
            }
        }
    }
    
    func showAlertWith(message: String, completion: @escaping (()->())){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (nil) in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleButtonFrom(_ sender: UIButton){
        dateLauncher.startDate = timeStart
        showDatePickerWith(mode: .time, sender: sender)
        
    }
    func handleButtonTo(_ sender: UIButton){
        dateLauncher.startDate = timeEnd
        showDatePickerWith(mode: .time, sender: sender)
    }
    
    func showDatePickerWith(mode : UIDatePickerMode, sender : UIButton){
        dateLauncher.pickerMode = mode
        dateLauncher.sender = sender
        dateLauncher.show()
    }
    
    func handleActionSheet(){
        let actionSheet = UIAlertController(title: nil, message: "loại công việc", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Huỷ bỏ", style: .cancel, handler: nil))
        for workType in workTypes!{
            actionSheet.addAction(UIAlertAction(title: workType.name, style: .default, handler: { (nil) in
                self.workType = workType
            }))
        }
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    //MARK: - validate
    func validate(completion: @escaping ((String?)->())){
        if let titleError = validateTitle() {
            completion(titleError)
            return
        }
        if let typeError = validateType(){
            completion(typeError)
            return
        }
        if let descriptionError = validateDescription() {
            completion(descriptionError)
            return
        }
        if let dateError = validateDate(){
            completion(dateError)
            return
        }
        if let packageError = validatePackage(){
            completion(packageError)
            return
        }
        validateAddress { (addressError) in
            if addressError != nil{
                completion(addressError)
            }
            else{
                completion(nil)
            }
        }
    }
    
    private func validateTitle() -> String?{
        if (titleTextField.text?.trimmingCharacters(in: .whitespaces).characters.count)! > 5   {
            params["title"] = titleTextField.text
            return nil
        }
        return "Vui lòng nhập title"
    }
    private func validateType() -> String?{
        if self.workType != nil   {
            params["work"] = workType?.id
            return nil
        }
        return "Vui lòng chọn Loại công việc"
    }
    private func validateDescription() -> String?{
        let numberChar = (descriptionTextField.text?.trimmingCharacters(in: .whitespaces).characters.count)!
        if  numberChar > 10 {
            params["description"] = descriptionTextField.text
            return nil
        }
        return "Vui lòng nhập mô tả công việc"
    }
    private func validateAddress(completion: @escaping ((String?)->())){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressTextField.text!) { (placeMarks, error) in
            if error == nil{
                if (placeMarks?.count)! > 0{
                    let firstLocation = placeMarks?.first?.location
                    self.params["addressName"] = self.addressTextField.text
                    self.params["lat"] = firstLocation?.coordinate.latitude
                    self.params["lng"] = firstLocation?.coordinate.longitude
                    completion(nil)
                }
                else{
                    completion("Địa chỉ nhập không đúng")
                }
            }else{
                completion("Địa chỉ nhập không đúng")
            }
        }
    }
    
    private func validatePackage()->String?{
        if self.radioButtonMoney.isSelected {
            self.params["package"] = "000000000000000000000001"
            if let priceNumber = Double(self.radioButtonMoney.titleView.text!){
                self.params["price"] = priceNumber
                return nil
            }else{
                return "Vui lòng chọn giá tiền"
            }
        }else{
            self.params["package"] = "000000000000000000000002"
            return nil
        }
        
    }
    
    private func validateDate() -> String?{
        if self.timeStart! < self.timeEnd!   {
            params["startAt"] = timeStart
            params["endAt"] = timeEnd
            return nil
        }
        return "Giờ bắt đầu phải nhỏ hơn giờ kết thúc"
    }
    
    //MARK: - delegate
    
    func selected(dateTime: Date, for sender: UIButton) {
        switch sender {
        case buttonDate:
            if dateTime != date{
                date = dateTime
            }
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == self.descriptionTextField {
            if (textField.text?.characters.count)! <= 200{
                return true
            }
        }
        return false
    }
    

}

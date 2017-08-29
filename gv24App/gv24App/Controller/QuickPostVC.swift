//
//  QuickPostVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 7/20/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import KMPlaceholderTextView

class QuickPostVC: BaseVC, DateTimeLauncherDelegate {
    var params = Dictionary<String, Any>()
    
    var workType : WorkType?{
        didSet{
            guard let workType = workType else {
                return
            }
            params["work"] = workType.id
            if let price = workType.price {
                self.radioButtonMoney.titleView.text = "\(price)"
            }
            self.workTypeTextField.text = workType.name
            self.labelDescription.text = workType.workDescription
            self.titleTextField.text = workType.title
        }
    }
    var chexboxes = [CheckBox]()
    
    var date : Date? {
        didSet{
            buttonDate.valueString = date?.dayMonthYear
            //if let myDate = self.date {
            //    timeStart = myDate
            //}
        }
    }
    var timeStart = Date() {
        didSet{
            timeEnd = timeStart.postDefaultDate()
            buttonFrom.title = timeStart.hourMinute
        }
    }
    var timeEnd = Date() {
        didSet{
            buttonTo.title = timeEnd.hourMinute
        }
    }
    
    lazy var dateLauncher : DateLauncher = {
        let launcher = DateLauncher()
        launcher.delegate = self
        return launcher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.collection
        hideKeyboardWhenTouchUpOutSize = true
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        title = workType?.name
        
        self.addressTextField.text = UserHelpers.currentUser?.address?.name
        
        // configure timeStart = now() + 10'
        var components = DateComponents()
        components.setValue(10, for: .minute)
        let now = Date()
        self.date = Calendar.current.date(byAdding: components, to: now)
        self.timeStart = self.date!
        self.timeEnd = self.date!.postDefaultDate()
        
        if workType?.id != "000000000000000000000001"{
            self.buttonWorkType.isUserInteractionEnabled = false
        }
    }
    override func setupRightNavButton() {
        let btnSend = NavButton(title: "Post")
        btnSend.addTarget(self, action: #selector(handlePostButton(_:)), for: .touchUpInside)
        btnSend.frame = CGRect(x: 0, y: 0, width: 70, height: 20)
        let btn = UIBarButtonItem(customView: btnSend)
        
        self.navigationItem.rightBarButtonItem = btn
    }
    
    let mainScrollView : UIScrollView = UIScrollView()
    let mainView : UIView = UIView()
    
    //MARK: - view 1 component
    let view1 : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        v.layer.masksToBounds = true
        return v
    }()
    
    let titleTextField : UITextFieldButtomLine = {
        let tF = UITextFieldButtomLine()
        tF.font = Fonts.by(name: .light, size: 15)
        tF.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tF.placeholder = LanguageManager.shared.localized(string: "Title")
        return tF
    }()
    
    let workTypeTextField : UITextFieldButtomLine = {
        let tF = UITextFieldButtomLine()
        tF.layer.masksToBounds = true
        tF.font = Fonts.by(name: .light, size: 15)
        tF.placeholder = LanguageManager.shared.localized(string: "TypesOfWork")
        tF.isUserInteractionEnabled = false
        return tF
    }()
    
    let buttonWorkType : UIButton = {
        let btn = UIButton(type: .custom)
        btn.addTarget(self, action: #selector(handleButtonWorkType(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let addressTextField : UITextFieldButtomLine = {
        let tF = UITextFieldButtomLine()
        tF.font = Fonts.by(name: .light, size: 15)
        tF.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tF.placeholder = LanguageManager.shared.localized(string: "Address")
        return tF
    }()
    
    let toolView : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.layer.masksToBounds = true
        v.backgroundColor = .white
        return v
    }()
    
    var toolViewHeightConstraint: NSLayoutConstraint?
    
    let checkBoxTool : CheckBox = {
        let cb = CheckBox()
        cb.addTarget(self, action: #selector(handleCheckBoxToolButton(_:)), for: .touchUpInside)
        cb.title = LanguageManager.shared.localized(string: "BringYourCleaningSupplies")
        return cb
    }()
    
    let labelDescription : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 0
        lb.font = Fonts.by(name: .regular, size: 15)
        return lb
    }()
    //MARK: - view 2 component
    let view2 : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    let radioButtonMoney : RadioButton = {
        let rb = RadioButton()
        rb.title = LanguageManager.shared.localized(string: "EnterTheSalary")
        rb.unit = "VND"
        rb.addTarget(self, action: #selector(handleRadioButton(_:)), for: .touchUpInside)
        return rb
    }()
    let radioButtonTime : RadioButton = {
        let rb = RadioButton()
        rb.showBottomLine = true
        rb.isSelected = true
        rb.title = LanguageManager.shared.localized(string: "Timework")
        rb.addTarget(self, action: #selector(handleRadioButton(_:)), for: .touchUpInside)
        return rb
    }()
    //MARK: - view 3 component
    let view3 : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    let buttonDate : ButtonTitleValue = {
        let btn = ButtonTitleValue()
        btn.title = LanguageManager.shared.localized(string: "TheStartDate")
        btn.valueString = Date().dayMonthYear
        btn.showBottomLine = true
        btn.addTarget(self, action: #selector(handleButtonDate(_:)), for: .touchUpInside)
        return btn
    }()
    
    let buttonFrom: BasicButton = {
        let btn = BasicButton()
        //btn.title = Date().hourMinute
        btn.titleCollor = AppColor.backButton
        btn.contentHorizontalAlignment = .left
        btn.addTarget(self, action: #selector(handleButtonFrom(_:)), for: .touchUpInside)
        return btn
    }()
    
    let buttonTo: BasicButton = {
        let btn = BasicButton()
        //btn.title = Date().postDefaultDate().hourMinute
        btn.titleCollor = AppColor.backButton
        btn.contentHorizontalAlignment = .right
        btn.addTarget(self, action: #selector(handleButtonTo(_:)), for: .touchUpInside)
        return btn
    }()
    //MARK: - view 4 component
    let view4 : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    let textViewDescription : UITextView = {
        let tv = KMPlaceholderTextView()
        tv.font = Fonts.by(name: .light, size: 13)
        tv.placeholder = LanguageManager.shared.localized(string: "WorkDescription")!
        return tv
    }()
    
    //MARK: - setup view
    override func setupView() {
        setupMainView()
        setupStruct()
        setupView1()
        setupToolView()
        setupView2()
        setupView3()
        setupView4()
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
    
    func setupStruct(){
        
        mainView.addSubview(view1)
        mainView.addSubview(toolView)
        mainView.addSubview(view2)
        mainView.addSubview(view3)
        mainView.addSubview(view4)
        
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: view1)
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: toolView)
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: view2)
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: view3)
        mainView.addConstraintWithFormat(format: "H:|[v0]|", views: view4)
        
        mainView.addConstraintWithFormat(format: "V:|[v0][v1]-20-[v2]-20-[v3]-20-[v4]-20-|", views: view1, toolView, view2, view3, view4)
    }
    func setupView1(){
        view1.addSubview(titleTextField)
        view1.addSubview(workTypeTextField)
        view1.addSubview(buttonWorkType)
        view1.addSubview(addressTextField)
        view1.addSubview(labelDescription)
        
        view1.addConstraintWithFormat(format: "V:|-10-[v0]-10-[v1]-10-[v2]-10-[v3]", views: titleTextField, workTypeTextField, addressTextField, labelDescription)
        view1.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: titleTextField)
        view1.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: addressTextField)
        view1.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: workTypeTextField)
        view1.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: labelDescription)
        workTypeTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        //        if workType?.id == "000000000000000000000001"{
        //
        //        }else{
        //            workTypeTextField.heightAnchor.constraint(equalToConstant: 0).isActive = true
        //        }
        buttonWorkType.topAnchor.constraint(equalTo: workTypeTextField.topAnchor, constant: 0).isActive = true
        buttonWorkType.leftAnchor.constraint(equalTo: workTypeTextField.leftAnchor, constant: 0).isActive = true
        buttonWorkType.rightAnchor.constraint(equalTo: workTypeTextField.rightAnchor, constant: 0).isActive = true
        buttonWorkType.bottomAnchor.constraint(equalTo: workTypeTextField.bottomAnchor, constant: 0).isActive = true
        
        if workType?.suggests.count == 0{
            addressTextField.bottomAnchor.constraint(equalTo: view1.bottomAnchor, constant: 0).isActive = true
            return
        }
        
        setupChexboxes()
        
        
    }
    
    func createCheckBoxes() -> CGFloat{
        let checkboxWidth = (UIScreen.main.bounds.width - 30) / numberCollum
        var checkboxHeight : CGFloat = 0
        let font = Fonts.by(name: .light, size: 15)
        chexboxes = [CheckBox]()
        for suggest in (workType?.suggests)!{
            let checkbox = CheckBox()
            checkbox.title = suggest.name
            checkbox.widthAnchor.constraint(equalToConstant: checkboxWidth).isActive = true
            view1.addSubview(checkbox)
            chexboxes.append(checkbox)
            let size = CGSize(width: checkboxWidth - 30, height: 1000)
            let height = checkbox.title?.heightWith(size: size, font: font)
            checkbox.addTarget(self, action: #selector(handleCheckbox(_:)), for: .touchUpInside)
            if checkboxHeight < height!{
                checkboxHeight = height!
            }
        }
        return checkboxHeight + 10
    }
    let numberCollum : CGFloat = 3
    func setupChexboxes(){
        
        let checkboxHeight = self.createCheckBoxes()
        let checkboxWidth = (UIScreen.main.bounds.width - 30) / numberCollum
        var currentRow : CGFloat = 0
        var currentCollum : CGFloat = 0
        
        for (index, checkbox) in self.chexboxes.enumerated(){
            
            checkbox.heightAnchor.constraint(equalToConstant: checkboxHeight).isActive = true
            checkbox.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: (10 + currentRow * checkboxHeight)).isActive = true
            checkbox.leftAnchor.constraint(equalTo: view1.leftAnchor, constant: (30 + checkboxWidth * currentCollum)).isActive = true
            
            if index == (workType?.suggests.count)! - 1 {
                checkbox.bottomAnchor.constraint(equalTo: view1.bottomAnchor, constant: -10).isActive = true
            }
            
            if currentCollum == numberCollum - 1{
                currentCollum = 0
                currentRow += 1
            }else{
                currentCollum = currentCollum + 1
            }
        }
    }
    
    func setupToolView(){
        toolView.addSubview(checkBoxTool)
        toolView.addConstraintWithFormat(format: "V:|[v0]|", views: checkBoxTool)
        toolView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: checkBoxTool)
        
        var height = 0
        if let enableTool = workType?.tools {
            height = enableTool ? 40 : 0
        }
        
        if let heightConstraint = toolViewHeightConstraint {
            heightConstraint.constant = CGFloat(height)
        } else {
            toolViewHeightConstraint = toolView.heightAnchor.constraint(equalToConstant: CGFloat(height))
            toolViewHeightConstraint?.isActive = true
        }
    }
    
    func setupView2(){
        view2.addSubview(radioButtonTime)
        view2.addSubview(radioButtonMoney)
        view2.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        view2.addConstraintWithFormat(format: "V:|[v0][v1]|", views: radioButtonTime, radioButtonMoney)
        view2.addConstraint(NSLayoutConstraint(item: radioButtonMoney, attribute: .height, relatedBy: .equal, toItem: radioButtonTime, attribute: .height, multiplier: 1, constant: 0))
        
        view2.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: radioButtonTime)
        view2.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: radioButtonMoney)    }
    func setupView3(){
        
        view3.addSubview(buttonDate)
        view3.heightAnchor.constraint(equalToConstant: 120).isActive = true
        buttonDate.topAnchor.constraint(equalTo: view3.topAnchor, constant: 0).isActive = true
        buttonDate.heightAnchor.constraint(equalToConstant: 40).isActive = true
        view3.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: buttonDate)
        
        let labelTime = UILabel()
        labelTime.font = Fonts.by(name: .light, size: 15)
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        labelTime.text = LanguageManager.shared.localized(string: "TimeOfWorking")
        
        let labelTo = UILabel()
        labelTo.font = Fonts.by(name: .light, size: 15)
        labelTo.translatesAutoresizingMaskIntoConstraints = false
        labelTo.text = LanguageManager.shared.localized(string: "To")
        labelTo.textAlignment = .center
        view3.addSubview(labelTime)
        view3.addSubview(labelTo)
        
        labelTime.topAnchor.constraint(equalTo: buttonDate.bottomAnchor, constant: 10).isActive = true
        labelTime.leftAnchor.constraint(equalTo: view3.leftAnchor, constant: 30).isActive = true
        
        labelTo.bottomAnchor.constraint(equalTo: view3.bottomAnchor, constant: -10).isActive = true
        labelTo.centerXAnchor.constraint(equalTo: view3.centerXAnchor, constant: 0).isActive = true
        labelTo.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        view3.addSubview(buttonFrom)
        view3.addSubview(buttonTo)
        
        buttonFrom.leftAnchor.constraint(equalTo: view3.leftAnchor, constant: 30).isActive = true
        buttonFrom.rightAnchor.constraint(equalTo: labelTo.leftAnchor, constant: 0).isActive = true
        buttonFrom.centerYAnchor.constraint(equalTo: labelTo.centerYAnchor, constant: 0).isActive = true
        buttonFrom.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        buttonTo.rightAnchor.constraint(equalTo: view3.rightAnchor, constant: -30).isActive = true
        buttonTo.leftAnchor.constraint(equalTo: labelTo.rightAnchor, constant: 0).isActive = true
        buttonTo.centerYAnchor.constraint(equalTo: labelTo.centerYAnchor, constant: 0).isActive = true
        buttonTo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    func setupView4(){
        view4.addSubview(textViewDescription)
        view4.addConstraintWithFormat(format: "V:|-10-[v0(100)]-10-|", views: textViewDescription)
        view4.addConstraintWithFormat(format: "H:|-25-[v0]-25-|", views: textViewDescription)
        
    }
    
    
    
    func showDatePickerWith(mode : UIDatePickerMode, sender : UIButton){
        hideKeyboard()
        dateLauncher.pickerMode = mode
        dateLauncher.sender = sender
        dateLauncher.show()
    }
    
    func showAlertWith(message: String, completion: @escaping (()->())){
        let mes = LanguageManager.shared.localized(string: message)
        let alert = UIAlertController(title: nil, message: mes, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LanguageManager.shared.localized(string: "OK"), style: .cancel, handler: { (nil) in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - handle button
    func handlePostButton(_ sender: UIButton){
        hideKeyboard()
        self.loadingView.show()
        validate { (errorString) in
            if errorString == nil{
                self.params["tools"] = self.checkBoxTool.isSelected
                TaskService.shared.postTask(params: self.params) { (error) in
                    self.loadingView.close()
                    if error == nil{
                        self.showAlertWith(message: "PostSuccessfully", completion: {
                            self.goBack()
                        })
                    }else{
                        self.showAlertWith(message: error!, completion: {})
                    }
                }
            }
            else{
                self.loadingView.close()
                self.showAlertWith(message: errorString!, completion: {})
            }
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
        let currentYear = Int(Date().year)
        self.dateLauncher.datePicker.maximumDate = Date(year: (currentYear! + 5))
        showDatePickerWith(mode: .date, sender: sender)
    }
    func handleButtonFrom(_ sender: UIButton){
        if timeStart < Date(){
            dateLauncher.startDate = Date()
        }else{
            dateLauncher.startDate = timeStart
        }
        dateLauncher.datePicker.maximumDate = nil
        showDatePickerWith(mode: .time, sender: sender)
        
    }
    func handleButtonTo(_ sender: UIButton){
        dateLauncher.startDate = timeEnd
        dateLauncher.datePicker.maximumDate = nil
        showDatePickerWith(mode: .time, sender: sender)
    }
    
    func handleCheckbox(_ sender : CheckBox){
        if sender.isSelected{
            sender.isSelected = false
        }else{
            sender.isSelected = true
        }
    }
    func handleButtonWorkType(_ sender: UIButton){
        let mes = LanguageManager.shared.localized(string: "TypesOfWork")
        let cancelString = LanguageManager.shared.localized(string: "Cancel")
        let actionSheet = UIAlertController(title: nil, message: mes, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: cancelString, style: .cancel, handler: nil))
        for workType in Constant.workTypes!{
            actionSheet.addAction(UIAlertAction(title: workType.name, style: .default, handler: { (nil) in
                self.workType = workType
                self.updatelayout()
            }))
        }
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func handleCheckBoxToolButton(_ sender: UIButton){
        if checkBoxTool.isSelected{
            checkBoxTool.isSelected = false
        }else{
            checkBoxTool.isSelected = true
        }
    }
    
    //MARK: - DateTimeLauncherDelegate
    
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
        return LanguageManager.shared.localized(string: "PleaseFillInTheTitle")
    }
    private func validateType() -> String?{
        if self.workType != nil   {
            params["work"] = workType?.id
            return nil
        }
        return LanguageManager.shared.localized(string: "PleaseChooseYourTypeOfWork")
    }
    private func validateDescription() -> String?{
        var checked : Bool = false
        var text = ""
        for (index, chexbox) in chexboxes.enumerated(){
            if chexbox.isSelected{
                checked = true
                text = text + (workType?.suggests[index].name)! + "\n"
            }
        }
        text = text + textViewDescription.text
        
        let numberChar = (text.trimmingCharacters(in: .whitespaces).characters.count)
        if  checked || numberChar > 10 {
            params["description"] = text
            return nil
        }
        return LanguageManager.shared.localized(string: "InvalidOtherRequestText")
    }
    private func validateAddress(completion: @escaping ((String?)->())){
        let text = addressTextField.text!
        LocationService.locationFor(address: text) { (coordinate, error) in
            if error != nil{
                print(error as Any)
                completion(LanguageManager.shared.localized(string: "AddressNotFound"))
            }else{
                self.params["addressName"] = self.addressTextField.text
                self.params["lat"] = coordinate?.latitude
                self.params["lng"] = coordinate?.longitude
                completion(nil)
            }
        }
    }
    private func validatePackage()->String?{
        if self.radioButtonMoney.isSelected {
            self.params["package"] = "000000000000000000000001"
            if let priceNumber = Double(self.radioButtonMoney.titleView.text!){
                if priceNumber >= 2000 {
                    self.params["price"] = priceNumber
                    return nil
                } else {
                    return LanguageManager.shared.localized(string: "InvalidPriceTextNumber")
                }
            }else{
                return LanguageManager.shared.localized(string: "PleaseEnterTheAmount")
            }
        }else{
            self.params["package"] = "000000000000000000000002"
            return nil
        }
    }
    
    private func validateDate() -> String?{
        if timeStart <= Date() || timeEnd <= Date(){
            return LanguageManager.shared.localized(string: "TimeOfWorkingIsInvalid")
        }
        if self.timeStart < self.timeEnd   {
            params["startAt"] = timeStart
            params["endAt"] = timeEnd
            return nil
        }
        return LanguageManager.shared.localized(string: "TheStartDateShouldBeLessThanTheEndDate")
    }
    
    //MARK: - handle keyboard
    func keyboardWillShow(notification : Notification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.mainScrollView.contentInset = contentInsets
            self.mainScrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    func keyboardWillHide(notification : Notification){
        let contentInsets = UIEdgeInsets.zero
        self.mainScrollView.contentInset = contentInsets
        self.mainScrollView.scrollIndicatorInsets = contentInsets
    }
    
    func updatelayout(){
        
        let subviews = view1.subviews + view2.subviews + view3.subviews + view4.subviews + toolView.subviews
        for subview in subviews {
            subview.removeFromSuperview()
        }
        view1.removeFromSuperview()
        toolView.removeFromSuperview()
        view2.removeFromSuperview()
        view3.removeFromSuperview()
        view4.removeFromSuperview()
        self.setupView()
        
    }
}

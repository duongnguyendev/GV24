//
//  GeneralStatisticVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/25/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class GeneralStatisticVC: BaseVC,DateTimeLauncherDelegate {
    var user : User?{
        didSet{
            self.avatarImage.loadImageUsingUrlString(urlString:(self.user?.avatarUrl)!)
        }
    }
    var starDate: Date?{
        didSet{
            loadData(startDate: starDate, endDate: endDate)
        }
    }
    var endDate: Date?{
        didSet{
            loadData(startDate: starDate, endDate: endDate)
        }
    }
    var generalStatisticData : GeneralStatistic?{
        didSet{
            infoView.generalStatisticData = generalStatisticData
            let numberAccountBalanceString = String.numberDecimalString(number: (generalStatisticData?.wallet)! as NSNumber)
            labelNumberAccountBalance.text =  numberAccountBalanceString + " vnd"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.collection
        title = LanguageManager.shared.localized(string: "GeneralStatistic")
        self.user = UserHelpers.currentUser
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData(startDate: starDate, endDate: endDate)
    }
    
    let buttonFrom: BasicButton = {
        let btn = BasicButton()
        btn.titleCollor = AppColor.backButton
        btn.title = "--/--/--"
        btn.titleFont = Fonts.by(name: .regular, size: 15)
        btn.addTarget(self, action: #selector(handleButtonFrom(_:)), for: .touchUpInside)
        return btn
    }()
    
    let buttonTo: BasicButton = {
        let btn = BasicButton()
        btn.titleCollor = AppColor.backButton
        btn.title = Date().dayMonthYear
        btn.titleFont = Fonts.by(name: .regular, size: 15)
        btn.addTarget(self, action: #selector(handleButtonTo(_:)), for: .touchUpInside)
        return btn
    }()
    let avatarImage : CustomImageView = {
        let iv = CustomImageView(image: UIImage(named: "avatar"))
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.widthAnchor.constraint(equalToConstant: 50).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 50).isActive = true
        iv.contentMode = .scaleToFill
        iv.layer.cornerRadius = 25
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let buttonRecharge : BasicButton = {
        let btn = BasicButton()
        btn.contentHorizontalAlignment = .left
        btn.titleFont = Fonts.by(name: .regular, size: 15)
        btn.titleCollor = AppColor.backButton
        btn.title = "Recharge"
        btn.addTarget(self, action: #selector(handleRechargeButton(_:)), for: .touchUpInside)
        return btn
    }()
    
    let dateView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        
        return view
    }()
    let accountView : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.white
        let topLine = UIView.horizontalLine()
        let bottomLine = UIView.horizontalLine()
        v.addSubview(topLine)
        v.addSubview(bottomLine)
        
        topLine.topAnchor.constraint(equalTo: v.topAnchor, constant: 0).isActive = true
        topLine.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0).isActive = true
        topLine.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0).isActive = true
        
        bottomLine.topAnchor.constraint(equalTo: v.bottomAnchor, constant: 0).isActive = true
        bottomLine.leftAnchor.constraint(equalTo: v.leftAnchor, constant: 0).isActive = true
        bottomLine.rightAnchor.constraint(equalTo: v.rightAnchor, constant: 0).isActive = true
        
        return v
    }()
    let labelNumberAccountBalance : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 13)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let infoView : GeneralStatisticInfoView = {
        let view = GeneralStatisticInfoView()
        return view
    }()
    lazy var dateLaucher : DateLauncher = {
        let launcher = DateLauncher()
        launcher.pickerMode = .date
        let calendar = Calendar(identifier: .gregorian)
        let currentYear = Int(Date().year)
        launcher.datePicker.maximumDate = Date()
        launcher.datePicker.minimumDate = Date(year: (currentYear! - 5))
        launcher.delegate = self
        return launcher
    }()
    override func setupView() {
        
        view.addSubview(dateView)
        view.addSubview(infoView)
        view.addSubview(accountView)
        
        view.addConstraintWithFormat(format: "V:|[v0(40)][v1]-20-[v2(100)]-20-|", views: dateView, infoView, accountView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: dateView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: infoView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: accountView)
        
        setupDateView()
        setupAccoutInfoView()
    }
    
    func setupDateView(){
        let labelTo = UILabel()
        labelTo.font = Fonts.by(name: .light, size: 15)
        labelTo.translatesAutoresizingMaskIntoConstraints = false
        labelTo.textAlignment = .center
        labelTo.text = LanguageManager.shared.localized(string: "To")
        
        let line = UIView.horizontalLine()
        
        dateView.addSubview(buttonFrom)
        dateView.addSubview(buttonTo)
        dateView.addSubview(labelTo)
        dateView.addSubview(line)
        
        labelTo.centerXAnchor.constraint(equalTo: dateView.centerXAnchor, constant: 0).isActive = true
        labelTo.centerYAnchor.constraint(equalTo: dateView.centerYAnchor, constant: 0).isActive = true
        labelTo.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        dateView.addConstraintWithFormat(format: "H:|[v0][v1][v2]|", views: buttonFrom, labelTo, buttonTo)
        
        view.addConstraintWithFormat(format: "V:|[v0]|", views: buttonFrom)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: buttonTo)
        
        line.bottomAnchor.constraint(equalTo: buttonFrom.bottomAnchor, constant: 0).isActive = true
        line.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        line.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
    }
    
    func setupAccoutInfoView(){
        super.setupView()
        let labelAccount = UILabel()
        labelAccount.font = Fonts.by(name: .medium, size: 16)
        labelAccount.translatesAutoresizingMaskIntoConstraints = false
        labelAccount.text = LanguageManager.shared.localized(string: "NGV247Account")
        
        let labelAccountBalance = UILabel()
        labelAccountBalance.font = Fonts.by(name: .light, size: 13)
        labelAccountBalance.translatesAutoresizingMaskIntoConstraints = false
        labelAccountBalance.text = LanguageManager.shared.localized(string: "AccountBalance")
        
        accountView.addSubview(avatarImage)
        accountView.addSubview(buttonRecharge)
        accountView.addSubview(labelAccountBalance)
        accountView.addSubview(labelAccount)
        accountView.addSubview(labelNumberAccountBalance)
        
        avatarImage.topAnchor.constraint(equalTo: accountView.topAnchor, constant: 5).isActive = true
        avatarImage.leftAnchor.constraint(equalTo: accountView.leftAnchor, constant: 10).isActive = true
        
        buttonRecharge.bottomAnchor.constraint(equalTo: accountView.bottomAnchor, constant: 0).isActive = true
        buttonRecharge.heightAnchor.constraint(equalToConstant: 40).isActive = true
        accountView.addConstraintWithFormat(format: "H:|-10-[v0]|", views: buttonRecharge)
        
        labelAccount.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 10).isActive = true
        labelAccount.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 5).isActive = true
        
        labelAccountBalance.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: 10).isActive = true
        labelAccountBalance.bottomAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: -5).isActive = true
        
        labelNumberAccountBalance.centerYAnchor.constraint(equalTo: labelAccountBalance.centerYAnchor, constant: 0).isActive = true
        labelNumberAccountBalance.leftAnchor.constraint(equalTo: labelAccountBalance.rightAnchor, constant: 0).isActive = true
        
        let line = UIView.horizontalLine()
        accountView.addSubview(line)
        line.bottomAnchor.constraint(equalTo: buttonRecharge.topAnchor, constant: 0).isActive = true
        accountView.addConstraintWithFormat(format: "H:|[v0]|", views: line)
    }
    
    func loadData(startDate : Date?, endDate: Date?){
        self.loadingView.show()
        TaskService.shared.generalStatistic(startDate: startDate, endDate: endDate) { (generalStatistic, error) in
            self.loadingView.close()
            if error != nil{
                let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                self.generalStatisticData = generalStatistic
            }
        }
    }
    
    func handleButtonFrom(_ sender: UIButton){
        dateLaucher.sender = sender
        var date = Date()
        if starDate == nil{
            dateLaucher.startDate = date
        }else{
            dateLaucher.startDate = starDate
        }
        if endDate != nil{
            dateLaucher.datePicker.maximumDate = endDate
            date = endDate!
        }else{
            dateLaucher.datePicker.maximumDate = date
        }
        
        dateLaucher.datePicker.minimumDate = Date(year: (Int(date.year)! - 5))
        dateLaucher.show()
    }
    func handleButtonTo(_ sender: UIButton){
        dateLaucher.sender = sender
        var date = Date()
        if endDate == nil{
            dateLaucher.startDate = Date()
        }else{
            dateLaucher.startDate = endDate
            date = endDate!
        }
        dateLaucher.datePicker.maximumDate = Date()
        if starDate != nil{
            dateLaucher.datePicker.minimumDate = starDate
        }else{
            dateLaucher.datePicker.minimumDate = Date(year: (Int(date.year)! - 5))
        }
        dateLaucher.show()
    }
    
    func handleRechargeButton(_ sender : UIButton){
        present(viewController: RechargeVC())
    }
    func selected(dateTime: Date, for sender: UIButton) {
        if sender == buttonFrom {
            buttonFrom.title = dateTime.dayMonthYear
            starDate = dateTime
        }else{
            buttonTo.title = dateTime.dayMonthYear
            endDate = dateTime
        }
    }
}

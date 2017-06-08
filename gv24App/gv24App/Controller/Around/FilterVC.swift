//
//  FilterVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/19/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import IoniconsSwift
import GoogleMaps

class FilterVC: BaseVC, AgeLauncherDelegate {
 
    var delegate : FilterDelegate?
    var distance : Int = 5{
        didSet{
            labelNumberDistance.text = "\(distance)km"
            
        }
    }
    
    var params = Dictionary<String, Any>()
    var workTypes : [WorkType]?
    var workType : WorkType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.collection
        sliderDistance.value = 5
        title = "Filter"
    }
    
    override func setupRightNavButton() {
        let buttonSearch = NavButton(title: "Tìm kiếm")
        buttonSearch.addTarget(self, action: #selector(handleSearchButton(_:)), for: .touchUpInside)
        let btn = UIBarButtonItem(customView: buttonSearch)
        self.navigationItem.rightBarButtonItem = btn
        

    }
    
    private let labelDistance : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Khoảng cách"
        lb.font = Fonts.by(name: .medium, size: 15)
        return lb
    }()
    private let labelNumberDistance : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textAlignment = .right
        lb.textColor = UIColor.lightGray
        lb.text = "5km"
        lb.font = Fonts.by(name: .light, size: 15)
        return lb
    }()
    private let labelMinDistance : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "0km"
        lb.font = Fonts.by(name: .light, size: 13)
        return lb
    }()
    private let labelMaxDistance : UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "10km"
        lb.textAlignment = .right
        lb.font = Fonts.by(name: .light, size: 13)
        return lb
    }()
    private let sliderDistance : UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.maximumValue = 10
        slider.minimumValue = 0
        slider.minimumTrackTintColor = AppColor.backButton
        slider.addTarget(self, action: #selector(sliderDidChangeValue(_:)), for: .valueChanged)
        return slider
    }()
    private let infoView = UIView()
    
    private let buttonPrice : InputButonWithIcon = {
        let btn = InputButonWithIcon()
        btn.iconName = Ionicons.socialUsd
        btn.title = "Giá tiền"
        btn.color = AppColor.backButton
        btn.addTarget(self, action: #selector(handleButtonPrice(_:)), for: .touchUpInside)
        return btn
    }()
    private let buttonType : InputButonWithIcon = {
        let btn = InputButonWithIcon()
        btn.iconName = Ionicons.gearA
        btn.title = "Loại công việc"
        btn.color = AppColor.backButton
        btn.addTarget(self, action: #selector(handleButtonType(_:)), for: .touchUpInside)
        return btn
    }()
    private let buttonGender : InputButonWithIcon = {
        let btn = InputButonWithIcon()
        btn.iconName = Ionicons.transgender
        btn.title = "Giới tính"
        btn.color = AppColor.backButton
        btn.addTarget(self, action: #selector(handleButtonGender(_:)), for: .touchUpInside)
        return btn
    }()
    private let buttonAge : InputButonWithIcon = {
        let btn = InputButonWithIcon()
        btn.iconName = Ionicons.androidCalendar
        btn.title = "Tuổi"
        btn.color = AppColor.backButton
        btn.addTarget(self, action: #selector(handleButtonAge(_:)), for: .touchUpInside)
        return btn
    }()
    lazy var ageLauncher : AgeLauncher = {
        let laucher = AgeLauncher()
        laucher.delegate = self
        return laucher
    }()
    override func setupView() {
        super.setupView()
        setupSliderView()
        setupInfoView()
        setupInfoComponent()
    }
    
    func setupSliderView(){
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        self.view.addSubview(view)
        view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        view.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        view.heightAnchor.constraint(equalToConstant: 90).isActive = true
        
        view.addSubview(labelDistance)
        view.addSubview(labelNumberDistance)
        view.addSubview(labelMinDistance)
        view.addSubview(labelMaxDistance)
        view.addSubview(sliderDistance)
        
        labelDistance.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        labelDistance.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        
        labelNumberDistance.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        labelNumberDistance.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        
        labelMinDistance.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        labelMinDistance.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        
        labelMaxDistance.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        labelMaxDistance.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        
        sliderDistance.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        sliderDistance.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        sliderDistance.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
    }

    func setupInfoView(){
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.backgroundColor = UIColor.white
        self.view.addSubview(infoView)
        infoView.topAnchor.constraint(equalTo: sliderDistance.bottomAnchor, constant: 50).isActive = true
        infoView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        infoView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        infoView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let topLine = UIView.horizontalLine()
        let bottomLine = UIView.horizontalLine()
        
        infoView.addSubview(topLine)
        infoView.addSubview(bottomLine)
        
        infoView.addConstraintWithFormat(format: "H:|[v0]|", views: topLine)
        infoView.addConstraintWithFormat(format: "H:|[v0]|", views: bottomLine)
        
        topLine.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 0).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 0).isActive = true
        
    }
    
    func setupInfoComponent(){
        infoView.addSubview(buttonPrice)
        infoView.addSubview(buttonType)
        infoView.addSubview(buttonAge)
        infoView.addSubview(buttonGender)
        
        buttonPrice.topAnchor.constraint(equalTo: infoView.topAnchor, constant: 0).isActive = true
        buttonPrice.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 20).isActive = true
        buttonPrice.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: 0).isActive = true
        buttonPrice.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        buttonType.topAnchor.constraint(equalTo: buttonPrice.bottomAnchor, constant: 0).isActive = true
        buttonType.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 20).isActive = true
        buttonType.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: 0).isActive = true
        buttonType.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        buttonGender.topAnchor.constraint(equalTo: buttonType.bottomAnchor, constant: 0).isActive = true
        buttonGender.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 20).isActive = true
        buttonGender.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: 0).isActive = true
        buttonGender.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        buttonAge.topAnchor.constraint(equalTo: buttonGender.bottomAnchor, constant: 0).isActive = true
        buttonAge.leftAnchor.constraint(equalTo: infoView.leftAnchor, constant: 20).isActive = true
        buttonAge.rightAnchor.constraint(equalTo: infoView.rightAnchor, constant: 0).isActive = true
        buttonAge.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    //MARK: - handle button
    
    func sliderDidChangeValue(_ sender : UISlider){
        distance = Int(sender.value)
        self.params["maxDistance"] = distance
    }
    func handleSearchButton(_ sender : UIButton){
        self.delegate?.filter!(params: params)
        self.goBack()
    }
    
    func handleButtonPrice(_ sender: UIButton){
        let actionSheet = UIAlertController(title: nil, message: "Giá tiền", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "<50.000", style: .default, handler: { (nil) in
            self.buttonPrice.title = "<50.000"
            self.params["priceMax"] = 50000
        }))
        actionSheet.addAction(UIAlertAction(title: "50.000 - 150.000", style: .default, handler: { (nil) in
            self.buttonPrice.title = "50.000 - 150.000"
            self.params["priceMin"] = 50000
            self.params["priceMax"] = 150000
        }))
        actionSheet.addAction(UIAlertAction(title: "150.000 - 250.000", style: .default, handler: { (nil) in
            self.buttonPrice.title = "150.000 - 250.000"
            self.params["priceMin"] = 150000
            self.params["priceMax"] = 250000
        }))
        actionSheet.addAction(UIAlertAction(title: "250.000 - 350.000", style: .default, handler: { (nil) in
            self.buttonPrice.title = "250.000 - 350.000"
            self.params["priceMin"] = 250000
            self.params["priceMax"] = 350000
        }))
        actionSheet.addAction(UIAlertAction(title: "350.000 - 450.000", style: .default, handler: { (nil) in
            self.buttonPrice.title = "350.000 - 450.000"
            self.params["priceMin"] = 350000
            self.params["priceMax"] = 450000
        }))
        actionSheet.addAction(UIAlertAction(title: ">450.000", style: .default, handler: { (nil) in
            self.buttonPrice.title = ">450.000"
            self.params["priceMin"] = 450000
        }))
        showAlert(alert: actionSheet)
        
    }
    func handleButtonType(_ sender: UIButton){
        
        if self.workTypes == nil{
            TaskService.shared.getWorkTypes { (workTypes, error) in
                if error == nil{
                    self.workTypes = workTypes
                    self.handleWorkTypes()
                }
            }
        }else{
            self.handleWorkTypes()
        }
        
    }
    
    func handleWorkTypes(){
        let actionSheet = UIAlertController(title: nil, message: "Loại công việc", preferredStyle: .actionSheet)
        for workType in workTypes!{
            actionSheet.addAction(UIAlertAction(title: workType.name, style: .default, handler: { (nil) in
                self.params["work"] = workType.id
                self.workType = workType
            }))
        }
        showAlert(alert: actionSheet)
    }
    func handleButtonGender(_ sender: UIButton){
        let actionSheet = UIAlertController(title: nil, message: "Giới tính", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Nam", style: .default, handler: { (nil) in
            self.params["gender"] = 0
            self.buttonGender.title = "Nam"
        }))
        actionSheet.addAction(UIAlertAction(title: "Nữ", style: .default, handler: { (nil) in
            self.params["gender"] = 1
            self.buttonGender.title = "Nữ"
        }))
        showAlert(alert: actionSheet)
    }
    func handleButtonAge(_ sender: UIButton){
        self.ageLauncher.show()
    }
    
    func showAlert(alert : UIAlertController){
        alert.addAction(UIAlertAction(title: "Huỷ bỏ", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func select(age: Int, toAge: Int) {
        self.params["ageMin"] = age
        self.params["ageMax"] = toAge
    }
}

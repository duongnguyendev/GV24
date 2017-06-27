//
//  SendOrderVC.swift
//  gv24App
//
//  Created by dinhphong on 6/26/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class SendOrderVC: BaseVC {
    var workSuccess = WorkUnpaid()
    
    let mainScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let contentView : UIView = {
        //content all view
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    
    private let labelName: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Họ tên người thanh toán"
        lb.textColor = .black
        lb.font = Fonts.by(name: .light, size: 14)
        return lb
    }()
    
    private let mtfName: InfoTextField = {
        let tf = InfoTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Họ & tên"
        return tf
    }()
    
    private let labelTotal: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Tổng số tiền cần thanh toán"
        lb.textColor = .black
        lb.font = Fonts.by(name: .light, size: 14)
        return lb
    }()
    
    private let mtfTotal: InfoTextField = {
        let tf = InfoTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .numberPad
        tf.placeholder = "Tổng số tiền"
        return tf
    }()

    private let labelEmail: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Email người thanh toán"
        lb.textColor = .black
        lb.font = Fonts.by(name: .light, size: 14)
        return lb
    }()
    
    private let mtfEmail: InfoTextField = {
        let tf = InfoTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Email"
        return tf
    }()

    private let labelPhone: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Số điện thoại người thanh toán"
        lb.textColor = .black
        lb.font = Fonts.by(name: .light, size: 14)
        return lb
    }()
    
    private let mtfPhone: InfoTextField = {
        let tf = InfoTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .numberPad
        tf.placeholder = "Phone"
        return tf
    }()

    private let labelAddress: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Địa chỉ người thanh toán"
        lb.textColor = .black
        lb.font = Fonts.by(name: .light, size: 14)
        return lb
    }()
    
    private let mtfAddress: InfoTextField = {
        let tf = InfoTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Địa chỉ"
        return tf
    }()

    private let buttonSend: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(handleSendButton(_:)), for: .touchUpInside)
        bt.backgroundColor = AppColor.homeButton3
        bt.setTitle("Send Order", for: .normal)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTouchUpOutSize = true
        view.backgroundColor = AppColor.collection
        title = "Thanh toán Online"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        self.mainScrollView.contentInset = contentInsets
        self.mainScrollView.scrollIndicatorInsets = contentInsets
    }
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            self.mainScrollView.contentInset = contentInsets
            self.mainScrollView.scrollIndicatorInsets = contentInsets
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mtfName.text = UserHelpers.currentUser?.userName
        mtfTotal.text = "\((workSuccess.price)!)"
        mtfEmail.text = UserHelpers.currentUser?.email
        mtfPhone.text = UserHelpers.currentUser?.phone
        mtfAddress.text = UserHelpers.currentUser?.address?.name
    }
    
    override func setupView() {
        super.setupView()
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(contentView)
        
        mainScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mainScrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        mainScrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        contentView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        contentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor, constant: 0).isActive = true
        contentView.leftAnchor.constraint(equalTo: mainScrollView.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: mainScrollView.rightAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor, constant: 0).isActive = true
        
        contentView.addSubview(labelName)
        contentView.addSubview(mtfName)
        contentView.addSubview(labelTotal)
        contentView.addSubview(mtfTotal)
        contentView.addSubview(labelEmail)
        contentView.addSubview(mtfEmail)
        contentView.addSubview(labelPhone)
        contentView.addSubview(mtfPhone)
        contentView.addSubview(labelAddress)
        contentView.addSubview(mtfAddress)
        contentView.addSubview(buttonSend)
        labelName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views: labelName)
        
        mtfName.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 10).isActive = true
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views: mtfName)
        mtfName.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        labelTotal.topAnchor.constraint(equalTo: mtfName.bottomAnchor, constant: 20).isActive = true
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views: labelTotal)
        
        mtfTotal.topAnchor.constraint(equalTo: labelTotal.bottomAnchor, constant: 10).isActive = true
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views: mtfTotal)
        mtfTotal.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        labelEmail.topAnchor.constraint(equalTo: mtfTotal.bottomAnchor, constant: 20).isActive = true
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views: labelEmail)
        
        mtfEmail.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 10).isActive = true
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views: mtfEmail)
        mtfEmail.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        labelPhone.topAnchor.constraint(equalTo: mtfEmail.bottomAnchor, constant: 20).isActive = true
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views: labelPhone)
        
        mtfPhone.topAnchor.constraint(equalTo: labelPhone.bottomAnchor, constant: 10).isActive = true
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views: mtfPhone)
        mtfPhone.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        labelAddress.topAnchor.constraint(equalTo: mtfPhone.bottomAnchor, constant: 20).isActive = true
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views: labelAddress)
        
        mtfAddress.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 10).isActive = true
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views: mtfAddress)
        mtfAddress.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        buttonSend.topAnchor.constraint(equalTo: mtfAddress.bottomAnchor, constant: 30).isActive = true
        contentView.addConstraintWithFormat(format: "H:|-30-[v0]-30-|", views: buttonSend)
        buttonSend.heightAnchor.constraint(equalToConstant: 40).isActive = true
        buttonSend.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
    
    //Mark: Handle Button Send
    func handleSendButton(_ sender: UIButton){
        
    }
}

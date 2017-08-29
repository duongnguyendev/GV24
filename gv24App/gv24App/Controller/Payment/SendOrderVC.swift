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
    var workPayment: WorkUnpaid?
    var taskPayment: Task?
    
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
    let labelName: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = LanguageManager.shared.localized(string: "PayerFullName")
        lb.textColor = .black
        lb.font = Fonts.by(name: .light, size: 14)
        return lb
    }()
    let mtfName: InfoTextField = {
        let tf = InfoTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let labelTotal: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = LanguageManager.shared.localized(string: "TotalAmount")
        lb.textColor = .black
        lb.font = Fonts.by(name: .light, size: 14)
        return lb
    }()
    
    let mtfTotalMoney: InfoTextField = {
        let tf = InfoTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .numberPad
        return tf
    }()

    let labelEmail: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = LanguageManager.shared.localized(string: "Email")
        lb.textColor = .black
        lb.font = Fonts.by(name: .light, size: 14)
        return lb
    }()
    
    let mtfEmail: InfoTextField = {
        let tf = InfoTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let labelPhone: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = LanguageManager.shared.localized(string: "PhoneNumber")
        lb.textColor = .black
        lb.font = Fonts.by(name: .light, size: 14)
        return lb
    }()
    
    let mtfPhone: InfoTextField = {
        let tf = InfoTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.keyboardType = .numberPad
        return tf
    }()

    let labelAddress: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = LanguageManager.shared.localized(string: "Address")
        lb.textColor = .black
        lb.font = Fonts.by(name: .light, size: 14)
        return lb
    }()
    
    let mtfAddress: InfoTextField = {
        let tf = InfoTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    private let buttonSend: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.addTarget(self, action: #selector(handleSendButton(_:)), for: .touchUpInside)
        bt.layer.cornerRadius = 5.0
        bt.backgroundColor = AppColor.homeButton3
        bt.setTitle(LanguageManager.shared.localized(string: "Request"), for: .normal)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTouchUpOutSize = true
        view.backgroundColor = AppColor.collection
        title = LanguageManager.shared.localized(string: "title.payment.online")
        
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
        mtfName.text = UserHelpers.currentUser?.name
        let priceString = String.numberDecimalString(number: (workPayment?.price)! as NSNumber)
        mtfTotalMoney.text = priceString
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
        contentView.addSubview(mtfTotalMoney)
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
        
        mtfTotalMoney.topAnchor.constraint(equalTo: labelTotal.bottomAnchor, constant: 10).isActive = true
        contentView.addConstraintWithFormat(format: "H:|-10-[v0]-10-|", views: mtfTotalMoney)
        mtfTotalMoney.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        labelEmail.topAnchor.constraint(equalTo: mtfTotalMoney.bottomAnchor, constant: 20).isActive = true
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
        let params = parameters(merchent_id: MERCHANT_ID, merchent_password: MERCHANT_PASSWORD, merchent_email: MERCHANT_ACCOUNT, order_code: ORDER_CODE)
        ManagerAPI.postData(fromServer: MAIN_URL_PUBLIC, andInfo: params, completionHandler: { (resultDict) in
            if let result = resultDict as? Dictionary<String, Any>{
                let response_code = result["response_code"] as? String
                if response_code == "00"{
                    let wvPaymentVC = WebviewPaymentVC()
                    wvPaymentVC.gstrUrl = result["checkout_url"] as? String
                    wvPaymentVC.token_code = result["token_code"] as? String
                    wvPaymentVC.taskPayment = self.taskPayment
                    wvPaymentVC.workPayment = self.workPayment
                    self.push(viewController: wvPaymentVC)
                }
            }
        }) { (error) in
            self.showAlertWith(message: LanguageManager.shared.localized(string: "PaymentFailed")!, completion: {})
        }
    }
    
    func parameters(merchent_id: String, merchent_password: String, merchent_email: String, order_code: String)->Dictionary<String, String>{
        var params = Dictionary<String,String>()
        var arrayValue = [ FUNC_ORDER, VERSION, merchent_id, merchent_email, order_code, mtfTotalMoney.text!, CURRENCY, LANGUAGE, RETURN_URL,
                           CANCEL_URL, NOTIFY_URL, mtfName.text!, mtfEmail.text!, mtfPhone.text! ,mtfAddress.text!]
        params["func"] = arrayValue[0]
        params["version"] = arrayValue[1]
        params["merchant_id"] = arrayValue[2]
        params["merchant_account"] = arrayValue[3]
        params["order_code"] = arrayValue[4]
        params["total_amount"] = arrayValue[5]
        params["currency"] = arrayValue[6]
        params["language"] = arrayValue[7]
        params["return_url"] = arrayValue[8]
        params["cancel_url"] = arrayValue[9]
        params["notify_url"] = arrayValue[10]
        params["buyer_fullname"] = arrayValue[11]
        params["buyer_email"] = arrayValue[12]
        params["buyer_mobile"] = arrayValue[13]
        params["buyer_address"] = arrayValue[14]
        
        let value = arrayValue.joined(separator: "|") + "|\(merchent_password)"
        let checksum = value.md5
        params["checksum"] = checksum
        
        return params
    }
    
    //MARK: - Show Message
    func showAlertWith(message: String, completion: @escaping (()->())){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (nil) in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }

}

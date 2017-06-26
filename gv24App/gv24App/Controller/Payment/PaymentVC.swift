//
//  PaymentVC.swift
//  gv24App
//
//  Created by dinhphong on 6/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class PaymentVC: BaseVC,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let jobCellId = "jobCellId"
    let billCellId = "billCellId"
    let profileCellId = "profileCellId"
    let moneyCellId = "moneyCellId"
    let bankCellId = "bankCellId"
    let totalCellId = "totalCellId"
    let headerId = "headerId"
    
    lazy var collectionPayment : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = AppColor.collection
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    let labelPaymentMethods: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = AppColor.lightGray
        lb.font = Fonts.by(name: .light, size: 14)
        lb.text = "Phương thức thanh toán"
        return lb
    }()
    
    let viewPaymentMethods: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let gv24PaymentButton : HomeFunctButton = {
        let bt = HomeFunctButton()
        bt.backgroundColor = UIColor.clear
        bt.imageName = "avatar"
        bt.title = "Tài khoản\nGv24"
        bt.textColor = AppColor.homeButton1
        bt.addTarget(self, action: #selector(handleButtonGv24(_:)), for: .touchUpInside)
        return bt
    }()
    let onlinePaymentButton : HomeFunctButton = {
        let bt = HomeFunctButton()
        bt.backgroundColor =  UIColor.clear
        bt.imageName = "avatar"
        bt.title = "Thanh toán\ntrực tuyến"
        bt.textColor = AppColor.homeButton2
        bt.addTarget(self, action: #selector(handleButtonOnlinePayment(_:)), for: .touchUpInside)
        return bt
    }()
    let moneyPaymentButton : HomeFunctButton = {
        let bt = HomeFunctButton()
        bt.backgroundColor =  UIColor.clear
        bt.imageName = "avatar"
        bt.title = "Thanh toán\ntiền mặt"
        bt.textColor = AppColor.homeButton3
        bt.addTarget(self, action: #selector(handleButtonMoneyPayment(_:)), for: .touchUpInside)
        return bt
        
    }()
    func handleButtonGv24(_ sender: UIButton){
        print("Handle Gv 24")
    }
    
    func handleButtonOnlinePayment(_ sender: UIButton){
        print("Handle Online Payment")
    }
    
    func handleButtonMoneyPayment(_ sender: UIButton){
        print("Handle Money Payment")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColor.collection
        title = "Thanh toán"
        collectionPayment.register(JobTypeCell.self, forCellWithReuseIdentifier: jobCellId)
        collectionPayment.register(KeyBillCell.self, forCellWithReuseIdentifier: billCellId)
        collectionPayment.register(ProfileMaidCell.self, forCellWithReuseIdentifier: profileCellId)
        collectionPayment.register(MoneyMaidCell.self, forCellWithReuseIdentifier: moneyCellId)
        collectionPayment.register(BankOwnerCell.self, forCellWithReuseIdentifier: bankCellId)
        collectionPayment.register(TotalMaidCell.self, forCellWithReuseIdentifier: totalCellId)
        collectionPayment.register(BaseHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId);
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func setupView() {
        super.setupView()
        
        view.addSubview(collectionPayment)
        view.addSubview(labelPaymentMethods)
        view.addSubview(viewPaymentMethods)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: collectionPayment)
        collectionPayment.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionPayment.heightAnchor.constraint(equalToConstant: view.frame.height * 2/3).isActive = true
        
        labelPaymentMethods.topAnchor.constraint(equalTo: collectionPayment.bottomAnchor, constant: 5).isActive = true
        labelPaymentMethods.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        labelPaymentMethods.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        viewPaymentMethods.topAnchor.constraint(equalTo: labelPaymentMethods.bottomAnchor, constant: 10).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: viewPaymentMethods)
        viewPaymentMethods.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        setupViewPaymentMethods()
    }
    
    func setupViewPaymentMethods(){
        viewPaymentMethods.addSubview(gv24PaymentButton)
        viewPaymentMethods.addSubview(onlinePaymentButton)
        viewPaymentMethods.addSubview(moneyPaymentButton)
        
        viewPaymentMethods.addConstraint(NSLayoutConstraint(item: gv24PaymentButton, attribute: .width, relatedBy: .equal, toItem: onlinePaymentButton, attribute: .width, multiplier: 1, constant: 0))
        viewPaymentMethods.addConstraint(NSLayoutConstraint(item: gv24PaymentButton, attribute: .width, relatedBy: .equal, toItem: moneyPaymentButton, attribute: .width, multiplier: 1, constant: 0))
        
        viewPaymentMethods.addConstraintWithFormat(format: "H:|[v0][v1][v2]|", views: gv24PaymentButton,onlinePaymentButton,moneyPaymentButton)
        
        gv24PaymentButton.topAnchor.constraint(equalTo: viewPaymentMethods.topAnchor, constant: 5).isActive = true
        onlinePaymentButton.topAnchor.constraint(equalTo: viewPaymentMethods.topAnchor, constant: 5).isActive = true
        moneyPaymentButton.topAnchor.constraint(equalTo: viewPaymentMethods.topAnchor, constant: 5).isActive = true
        
        gv24PaymentButton.bottomAnchor.constraint(equalTo: viewPaymentMethods.bottomAnchor, constant: 5).isActive = true
        onlinePaymentButton.bottomAnchor.constraint(equalTo: viewPaymentMethods.bottomAnchor, constant: 5).isActive = true
        moneyPaymentButton.bottomAnchor.constraint(equalTo: viewPaymentMethods.bottomAnchor, constant: 5).isActive = true
    }
    
    //MARK: - Collection view delegate - datasourse
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.item == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: jobCellId, for: indexPath) as! JobTypeCell
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: billCellId, for: indexPath) as! KeyBillCell
                return cell
            }
        case 1:
            if indexPath.item == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileCellId, for: indexPath) as! ProfileMaidCell
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: moneyCellId, for: indexPath) as! MoneyMaidCell
                return cell
            }
        case 2:
            if indexPath.item == 0{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bankCellId, for: indexPath) as! BankOwnerCell
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: totalCellId, for: indexPath) as! TotalMaidCell
                return cell
            }
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: jobCellId, for: indexPath) as! JobTypeCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 && indexPath.item == 1{
            return CGSize(width: view.frame.size.width, height: 45)
        }else if indexPath.section == 2 && indexPath.item == 1{
            return CGSize(width: view.frame.size.width, height: 30)
        }
        return CGSize(width: view.frame.size.width, height: 70)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 20)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? BaseHeaderView
        return headerView!
    }
    
}

//
//  MaidWorkInfoCell.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/6/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
class MaidWorkInfoCell: BaseCollectionCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var maid : MaidProfile?{
        didSet{
            let hString = LanguageManager.shared.localized(string: "H")!
            let priceString = String.numberDecimalString(number: maid?.workInfo?.price ?? 0)
            self.labelPrice.text = "\(priceString)" + " VND/\(hString)"
            self.collectionWorkInfo.reloadData()
        }
    }
    var delegate : MaidProfileDelegate?
    let workInfoCellId = "workInfoCellId"
    
    let labelPrice : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    let labelReport : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = AppColor.backButton
        lb.text = LanguageManager.shared.localized(string: "Feedback")
        return lb
    }()
    let labelChoose : UILabel = {
        let lb = UILabel()
        lb.font = Fonts.by(name: .light, size: 15)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = AppColor.backButton
        lb.text = LanguageManager.shared.localized(string: "SelectYourApplicants")
        return lb
    }()
    lazy var collectionWorkInfo : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let buttonReport = UIButton(type: .custom)
    let buttonChoose = UIButton(type: .custom)
    
    let iconPrice = IconView(icon: .socialUsd, size: 15, color: AppColor.backButton)
    let iconCheck = IconView(icon: .checkmark, size: 15, color: AppColor.backButton)
    let priceLine = UIView.horizontalLine()
    let reportLine = UIView.horizontalLine()
    let chooseLine = UIView.horizontalLine()
    let collectionLine = UIView.horizontalLine()
    
    override func setupView() {
        collectionWorkInfo.register(AbilityCell.self, forCellWithReuseIdentifier: workInfoCellId)
        
        buttonReport.addTarget(self, action: #selector(handleReportButton(_:)), for: .touchUpInside)
        buttonChoose.addTarget(self, action: #selector(handleChooseButton(_:)), for: .touchUpInside)
        backgroundColor = UIColor.white
        
        addSubview(labelPrice)
        addSubview(labelReport)
        addSubview(labelChoose)
        addSubview(collectionWorkInfo)
        addSubview(iconCheck)
        addSubview(iconPrice)
        addSubview(priceLine)
        addSubview(collectionLine)
        addSubview(reportLine)
        addSubview(chooseLine)
        addSubview(buttonReport)
        addSubview(buttonChoose)
        
        iconPrice.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        iconPrice.rightAnchor.constraint(equalTo: labelPrice.leftAnchor, constant: -10).isActive = true
        iconPrice.centerYAnchor.constraint(equalTo: labelPrice.centerYAnchor, constant: 0).isActive = true
        
        priceLine.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: 0).isActive = true
        priceLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        priceLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        labelPrice.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelPrice.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelPrice.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        
        collectionWorkInfo.topAnchor.constraint(equalTo: labelPrice.bottomAnchor, constant: 0).isActive = true
        collectionWorkInfo.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        collectionWorkInfo.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        collectionWorkInfo.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        collectionLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        collectionLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        collectionLine.topAnchor.constraint(equalTo: collectionWorkInfo.bottomAnchor, constant: 0).isActive = true
        
        reportLine.topAnchor.constraint(equalTo: labelReport.bottomAnchor, constant: 0).isActive = true
        reportLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        reportLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        labelReport.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelReport.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelReport.topAnchor.constraint(equalTo: collectionLine.topAnchor, constant: 0).isActive = true
        labelReport.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        iconCheck.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        iconCheck.centerYAnchor.constraint(equalTo: labelChoose.centerYAnchor, constant: 0).isActive = true
        
        chooseLine.topAnchor.constraint(equalTo: labelChoose.bottomAnchor, constant: 0).isActive = true
        chooseLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        chooseLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        
        labelChoose.heightAnchor.constraint(equalToConstant: 40).isActive = true
        labelChoose.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        labelChoose.topAnchor.constraint(equalTo: labelReport.bottomAnchor, constant: 0).isActive = true
        labelChoose.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        
        buttonChoose.translatesAutoresizingMaskIntoConstraints = false
        buttonReport.translatesAutoresizingMaskIntoConstraints = false
        
        buttonChoose.leftAnchor.constraint(equalTo: labelChoose.leftAnchor, constant: 0).isActive = true
        buttonChoose.rightAnchor.constraint(equalTo: labelChoose.rightAnchor, constant: 0).isActive = true
        buttonChoose.topAnchor.constraint(equalTo: labelChoose.topAnchor, constant: 0).isActive = true
        buttonChoose.bottomAnchor.constraint(equalTo: labelChoose.bottomAnchor, constant: 0).isActive = true
        
        buttonReport.leftAnchor.constraint(equalTo: labelReport.leftAnchor, constant: 0).isActive = true
        buttonReport.rightAnchor.constraint(equalTo: labelReport.rightAnchor, constant: 0).isActive = true
        buttonReport.topAnchor.constraint(equalTo: labelReport.topAnchor, constant: 0).isActive = true
        buttonReport.bottomAnchor.constraint(equalTo: labelReport.bottomAnchor, constant: 0).isActive = true
    }
    
    //MARK: - collection view delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return (maid?.workInfo?.ability?.count) ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: workInfoCellId, for: indexPath) as! AbilityCell
        cell.ability = maid?.workInfo?.ability?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func handleChooseButton(_ sender: UIButton){
        if delegate != nil{
            self.delegate?.choose()
        }
    }
    func handleReportButton(_ sender: UIButton){
        if delegate != nil{
            self.delegate?.report()
        }
    }
}

//
//  TransferInfoVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/13/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class TransferInfoVC: BaseVC {
    
    var contact : Contact?{
        didSet{
            labelNote.text = contact?.note
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Thông tin chuyển khoản"
        view.backgroundColor = AppColor.collection
        // Do any additional setup after loading the view.
    }
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "THÔNG TIN TÀI KHOẢN"
        label.font = Fonts.by(name: .light, size: 15)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let labelNote : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lưu ý: nên giữ lại biên lai chuyển tiền, nhất là những trường hợp chuyển từ cây ATM không ghi được nội dung.\nSau khi chuyển xong hãy chat trực tiếp với nhân viên bán hàng ở phần dưới và chụp lại biên lai chuyển tiền để được thanh toán nhanh nhất."
        label.numberOfLines = 0
        label.font = Fonts.by(name: .light, size: 13)
        label.textAlignment = .justified
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let contactView : UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor.white
        let topLine = UIView.horizontalLine()
        let bottomLine = UIView.horizontalLine()
        v.addSubview(topLine)
        v.addSubview(bottomLine)
        v.addConstraintWithFormat(format: "H:|[v0]|", views: topLine)
        v.addConstraintWithFormat(format: "H:|[v0]|", views: bottomLine)
        
        topLine.topAnchor.constraint(equalTo: v.topAnchor, constant: 0).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0).isActive = true
        return v
    }()
    
    override func setupView() {
        
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        setupContactInfoView()
        setupNoteLabel()
    }
    
    func setupContactInfoView(){
        
        view.addSubview(contactView)
        contactView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        view.addConstraintWithFormat(format: "H:|[v0]|", views: contactView)
        
        let labelBank = UILabel()
        labelBank.translatesAutoresizingMaskIntoConstraints = false
        labelBank.font = Fonts.by(name: .medium, size: 15)
        labelBank.text = "Vietcombank"
        labelBank.textAlignment = .left
        let labelInfo = UILabel()
        labelInfo.translatesAutoresizingMaskIntoConstraints = false
        labelInfo.font = Fonts.by(name: .regular, size: 13)
        labelInfo.text = "Số tài khoản: 123456789\nTên người hưởng: Nguyễn Văn B\nChi nhánh Hồ Chí Minh\nNội dung: NAP NGUYENVANB@GMAIL.COM"
        labelInfo.numberOfLines = 0
        labelInfo.textAlignment = .left
        
        contactView.addSubview(labelBank)
        contactView.addSubview(labelInfo)
        
        contactView.addConstraintWithFormat(format: "V:|-20-[v0]-10-[v1]-20-|", views: labelBank, labelInfo)
        contactView.addConstraintWithFormat(format: "H:|-20-[v0]-15-|", views: labelBank)
        contactView.addConstraintWithFormat(format: "H:|-20-[v0]-20-|", views: labelInfo)
    }
    
    func setupNoteLabel(){
        view.addSubview(labelNote)
        
        labelNote.topAnchor.constraint(equalTo: contactView.bottomAnchor, constant: 20).isActive = true
        labelNote.leftAnchor.constraint(equalTo: contactView.leftAnchor, constant: 20).isActive = true
        labelNote.rightAnchor.constraint(equalTo: contactView.rightAnchor, constant: -20).isActive = true
    }
}

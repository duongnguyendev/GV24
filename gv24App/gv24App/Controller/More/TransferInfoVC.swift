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
            bankWebview.loadHTMLString((contact?.bank)!, baseURL: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LanguageManager.shared.localized(string: "RemittanceInformation")
        // Do any additional setup after loading the view.
    }
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LanguageManager.shared.localized(string: "AccountInformation")
        label.font = Fonts.by(name: .light, size: 15)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let labelNote : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
    let bankWebview : UIWebView = {
        let webView = UIWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        webView.scrollView.isScrollEnabled = false
        return webView
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
        
        contactView.addSubview(labelBank)
        contactView.addSubview(bankWebview)
        
        contactView.addConstraintWithFormat(format: "V:|-20-[v0]-10-[v1(250)]|", views: labelBank, bankWebview)
        contactView.addConstraintWithFormat(format: "H:|-20-[v0]-15-|", views: labelBank)
        contactView.addConstraintWithFormat(format: "H:|-15-[v0]-15-|", views: bankWebview)
    }
    
    func setupNoteLabel(){
        view.addSubview(labelNote)
        
        labelNote.topAnchor.constraint(equalTo: contactView.bottomAnchor, constant: 20).isActive = true
        labelNote.leftAnchor.constraint(equalTo: contactView.leftAnchor, constant: 20).isActive = true
        labelNote.rightAnchor.constraint(equalTo: contactView.rightAnchor, constant: -20).isActive = true
    }
}

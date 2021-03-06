//
//  TermsVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/26/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class TermsVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LanguageManager.shared.localized(string: "TermsOfUse")
        MoreService.shared.getTerms { (htmlString, error) in
            if error == nil{
                self.webView.loadHTMLString(htmlString!, baseURL: nil)
            }else{
                self.showAlertWith(title: nil, message: error)
            }
            
        }
    }
//    let labelContent : UILabel = {
//        let lb = UILabel()
//        lb.textAlignment = .justified
//        lb.text = LanguageManager.shared.localized(string: "Terms")
//        lb.numberOfLines = 0
//        lb.translatesAutoresizingMaskIntoConstraints = false
//        lb.font = Fonts.by(name: .regular, size: 14)
//        return lb
//        
//    }()

    let webView : UIWebView = {
        let webView = UIWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        return webView
    }()
    
    override func setupView() {
        super.setupView()
        
        view.addSubview(webView)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: webView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: webView)
        
//        let scrollViewContent = UIScrollView()
//        let contentView = UIView()
//        
//        view.addSubview(scrollViewContent)
//        scrollViewContent.addSubview(contentView)
//        
//        scrollViewContent.translatesAutoresizingMaskIntoConstraints = false
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        
//        scrollViewContent.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
//        scrollViewContent.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
//        scrollViewContent.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
//        scrollViewContent.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
//        
//        contentView.topAnchor.constraint(equalTo: scrollViewContent.topAnchor, constant: 0).isActive = true
//        contentView.leftAnchor.constraint(equalTo: scrollViewContent.leftAnchor, constant: 0).isActive = true
//        contentView.rightAnchor.constraint(equalTo: scrollViewContent.rightAnchor, constant: 0).isActive = true
//        contentView.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor, constant: 0).isActive = true
//        
//        contentView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
//        
//        contentView.addSubview(labelContent)
//        
//        contentView.addConstraintWithFormat(format: "V:|-\(margin)-[v0]-\(margin)-|", views: labelContent)
//        
//        labelContent.widthAnchor.constraint(equalToConstant: view.frame.size.width - margin).isActive = true
//        labelContent.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
    }
    func showAlertWith(title: String?, message: String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

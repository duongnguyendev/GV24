//
//  AboutUsVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/26/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class AboutUsVC: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = LanguageManager.shared.localized(string: "AboutUs")
        MoreService.shared.getAbout { (htmlString) in
            print(htmlString as Any)
        }
    }
    
    let logoImage : IconView = {
        let iv = IconView(image: "logo2", size: 100)
        return iv
    }()
    let labelContent : UILabel = {
        let lb = UILabel()
        lb.textAlignment = .justified
        lb.text = LanguageManager.shared.localized(string: "Terms")
        lb.numberOfLines = 0
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = Fonts.by(name: .regular, size: 14)
        return lb
        
    }()
    
    override func setupView() {
        super.setupView()
        
        let scrollViewContent = UIScrollView()
        let contentView = UIView()
        
        view.addSubview(scrollViewContent)
        scrollViewContent.addSubview(contentView)
        
        scrollViewContent.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollViewContent.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollViewContent.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollViewContent.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollViewContent.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:0).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollViewContent.topAnchor, constant: 0).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollViewContent.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollViewContent.rightAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor, constant: 0).isActive = true
        
        contentView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        
        
        contentView.addSubview(logoImage)
        contentView.addSubview(labelContent)
        
        contentView.addConstraintWithFormat(format: "V:|-\(margin)-[v0]-\(margin)-[v1]-\(margin)-|", views: logoImage, labelContent)
        logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
        
        labelContent.widthAnchor.constraint(equalToConstant: view.frame.size.width - (2 * margin)).isActive = true
        labelContent.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
    }
}

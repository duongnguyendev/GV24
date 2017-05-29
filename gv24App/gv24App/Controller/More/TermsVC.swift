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

        title = "Điều khoản"
    }
    let labelContent : UILabel = {
        let lb = UILabel()
        lb.textAlignment = .justified
        lb.text = "\tThe world cellular, as it describes phone technology, was used by engineers Douglas H. Ring and W. Rae Young at Bell Labs. They diagrammed a network of wireless towers into what they called a cellular layout. Cellular was the chosen term because each tower and its coverage map looked like a biological cell. Eventually, phones that operated on this type of wireless network were called cellular phones.\n\n\tThe term mobile phone predates its cellular counterpart. The first mobile phone call was placed in 1946 over Bell System's Mobile telephone service, a closed radiotelephone system. And the first commercial mobile phones were installed cars in the 1970s.\n\n\tEventually, the two names, mobile phone and cellular phone, became synonymous, especially here in the US. But some people disagree with that usage. They consider the term \"cellular phone\" to be a misnomer because the phone is not cellular, the network is. The phone is a mobile phone and it operates on a cellular network."
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
        scrollViewContent.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollViewContent.topAnchor, constant: 0).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollViewContent.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollViewContent.rightAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollViewContent.bottomAnchor, constant: 0).isActive = true
        
        contentView.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        
        contentView.addSubview(labelContent)
        
        contentView.addConstraintWithFormat(format: "V:|-\(margin)-[v0]-\(margin)-|", views: labelContent)
        
        labelContent.widthAnchor.constraint(equalToConstant: view.frame.size.width - margin).isActive = true
        labelContent.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0).isActive = true
    }

    
}

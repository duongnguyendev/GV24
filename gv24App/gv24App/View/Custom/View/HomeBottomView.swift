//
//  HomeBottomView.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/3/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
class BaseView : UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    func setupView(){
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeBottomView: BaseView {
    
    var slogan : String?{
        didSet{
            sloganLabel.text = LanguageManager.shared.localized(string: slogan!)
        }
    }
    
    private let logoView : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "logo"))
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    private let sloganLabel : UILabel = {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.font = Fonts.by(name: .light, size: 14)
        return lb
    }()
    override func setupView() {
        addSubview(logoView)
        addSubview(sloganLabel)
        
        addConstraintWithFormat(format: "H:|[v0]|", views: logoView)
        addConstraintWithFormat(format: "H:|[v0]|", views: sloganLabel)
        
        addConstraintWithFormat(format: "V:|-10-[v0]-10-[v1]-10-|", views: logoView, sloganLabel)
        
        addConstraint(NSLayoutConstraint(item: logoView, attribute: .height, relatedBy: .equal, toItem: sloganLabel, attribute: .height, multiplier: 2, constant: 0))
    }
    
}

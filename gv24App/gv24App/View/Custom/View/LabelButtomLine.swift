//
//  LabelButtomLine.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/2/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class UITextFieldButtomLine: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bottomLine)
        self.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        bottomLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        bottomLine.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
    }
    
    private let bottomLine = UIView.horizontalLine()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}

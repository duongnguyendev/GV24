//
//  InfoTextField.swift
//  gv24App
//
//  Created by dinhphong on 6/26/17.
//  Copyright © 2017 HBBs. All rights reserved.
//
import Foundation
import UIKit
class BaseTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    func setupView(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class InfoTextField: BaseTextField {
    
    override func setupView() {
        super.setupView()
        backgroundColor = .white
        
        //let textFieldContent = UITextField()
        self.textAlignment = NSTextAlignment.left
        self.font = Fonts.by(name: .regular, size: 14)
        self.textColor = .black
        self.borderStyle = .roundedRect
    }
    
}


//
//  PostVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//
import UIKit

class PostVC: QuickPostVC, UITextFieldDelegate {
    
    override func setupBackButton() {
        //super.setupBackButton()
        
        let buttonClose = NavButton.init(icon: .closeRound)
        buttonClose.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        buttonClose.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let btn = UIBarButtonItem(customView: buttonClose)
        
        self.navigationItem.leftBarButtonItem = btn
    }
    
    @objc fileprivate func handleCloseButton() {
        dismiss(animated: true, completion: nil)
    }
}

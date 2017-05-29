//
//  FilterVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/19/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class FilterVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Filter"
    }
    
    override func setupRightNavButton() {
        let buttonSearch = NavButton(title: "Tìm kiếm")
        buttonSearch.addTarget(self, action: #selector(handleSearchButton(_:)), for: .touchUpInside)
        let btn = UIBarButtonItem(customView: buttonSearch)
        self.navigationItem.rightBarButtonItem = btn

    }
    
    override func setupView() {
        super.setupView()
    }
    
    
    
    
    //MARK: - handle button
    
    func handleSearchButton(_ sender : UIButton){
        print("handleSearchButton")
    }
}

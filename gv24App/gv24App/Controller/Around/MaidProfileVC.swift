//
//  MaidProfileVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class MaidProfileVC: BaseVC {

    var maid : MaidProfile?{
        didSet{
            title = maid?.userName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

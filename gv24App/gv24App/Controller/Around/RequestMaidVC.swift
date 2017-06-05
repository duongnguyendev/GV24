//
//  RequestMaidVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/31/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class RequestMaidVC: PostVC {
    
    var maid : MaidProfile?{
        didSet{
            //            self.avatarImageView.loadImageUsingUrlString(urlString: (maid?.avatarUrl)!)
            //            self.labelName.text = maid?.name
            //            self.labelAddress.text = maid?.address?.name
        }
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gửi yêu cầu"
    }
    
    override func handlePostButton(_ sender: UIButton) {
        
    }
}

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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gửi yêu cầu"
    }
    
    override func handlePostButton(_ sender: UIButton) {
        validate { (errorString) in
            if errorString == nil{
                self.params["tools"] = self.checkBoxTool.isSelected
                self.params["maidId"] = self.maid?.userId
                TaskService.shared.sendRequestToMaid(params: self.params) { (error) in
                    if error == nil{
                        self.showAlertWith(message: "Đăng bài thành công", completion: {
                            self.goBack()
                        })
                    }else{
                        self.showAlertWith(message: error!, completion: {})
                    }
                }
            }
            else{
                self.showAlertWith(message: errorString!, completion: {})
            }
        }
    }
}

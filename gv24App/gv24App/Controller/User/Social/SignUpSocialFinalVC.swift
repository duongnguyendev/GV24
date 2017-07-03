//
//  SignSocialFinalVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/22/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class SignUpSocialFinalVC: SignUpVC_3 {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func handleButtonComplate(_ sender: UIButton) {
        self.loadingView.show()
        UserService.shared.signUpSocical(userInfo: self.user!) { (user, token, error) in
            self.loadingView.close()
            if error != nil{
                let alert = UIAlertController(title: "Lỗi", message: error, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                UserHelpers.save(user: user!, token: token!)
                self.navigationController?.dismiss(animated: true, completion: {
                    self.delegate?.signUpComplete!()
                })
            }
        }
    }
}

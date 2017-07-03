//
//  LaunchScreenVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/14/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class LaunchScreenVC: BaseVC {
    
    var appStarted : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupView() {
        super.setupView()
    }
    
    private func showSign(){
        appStarted = true
        let nav = UINavigationController(rootViewController: SignInVC())
        self.present(nav, animated: true, completion: nil)
        
    }
    private func showHome(){
        appStarted = true
        let nav = UINavigationController(rootViewController: HomeVC())
        self.present(nav, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserHelpers.isLogin == true{
            handleLogedIn()
        }else{
            showSign()
        }
    }
    func handleLogedIn() {
        if !appStarted{
            self.loadingView.show()
            UserService.shared.checkStatus { (error) in
                self.loadingView.close()
                if error != nil{
                    UserHelpers.logOut()
                    self.showSign()
                }else{
                    self.showHome()
                }
            }
        }else{
            self.showHome()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

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
        
        let logoImage = UIImageView(image: UIImage(named: "logo"))
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.contentMode = .scaleAspectFit
        view.addSubview(logoImage)
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        
        view.addConstraint(NSLayoutConstraint(item: logoImage, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 2/3, constant: 0))
        
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
        if !(NetworkStatus.sharedInstance.reachabilityManager?.isReachable)!{
            self.handleInternet(isConnected: false)
        }
        NetworkStatus.sharedInstance.startNetworkReachabilityObserver { (isInternetConnected) in
            self.handleInternet(isConnected: isInternetConnected)
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
    
    func handleInternet(isConnected : Bool){
        if isConnected {
            internetDisconnectView.close()
        }else{
            internetDisconnectView.show()
        }
    }
    let internetDisconnectView = InternetDisconnectView()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//
//  BaseVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/3/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import IoniconsSwift

class BaseVC: UIViewController {
    
    var isPresented : Bool?
    
    var isPresentLogout: Bool?
    
    let margin : CGFloat = 30
    
    var hideKeyboardWhenTouchUpOutSize : Bool?{
        didSet{
            if hideKeyboardWhenTouchUpOutSize == true {
                let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(tap)
            }
        }
    }
    
    var hiddenNav: Bool = false {
        didSet{
            self.navigationController?.isNavigationBarHidden = hiddenNav
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColor.backGround
        print(self)
        hiddenNav = false

        setupNav()
        setupRightNavButton()
        setupView()
        setupLeftNavButton()
    }
    
    let loadingView = LoadingView()
    
    override func viewWillAppear(_ animated: Bool) {
        setupBackButton()
        localized()
        print(self)
    }
    
    //MARK: - Setup navigation bar
    
    func setupNav() {
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.black,
             NSFontAttributeName: Fonts.by(name: .bold, size: 15)]
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupBackButton() {
        if isPresented != nil {
            let backButton = BackButton()
            backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
            let navLeftButton = UIBarButtonItem(customView: backButton)
            self.navigationItem.leftBarButtonItem = navLeftButton
        }
    }
    func setupRightNavButton() {
        
    }
    func setupLeftNavButton() {
        if isPresentLogout != nil {
            let backButton = BackBtPresent()
            backButton.addTarget(self, action: #selector(goBackLogout), for: .touchUpInside)
            let navLeftButton = UIBarButtonItem(customView: backButton)
            self.navigationItem.leftBarButtonItem = navLeftButton
        }
    }
    
    
    //MARK: - navigation handle
    func goBack() {
        if isPresented! {
            self.dismiss(animated: true, completion: nil)
        }else{
            if let nav = self.navigationController{
                nav.popViewController(animated: true)
            }
        }
    }
    
    //MARK: - navigation handle back when present
    func goBackLogout(){
        if isPresentLogout! {
            self.dismiss(animated: true, completion: nil)
        }else{
            if let nav = self.navigationController{
                nav.popViewController(animated: true)
            }
        }
    }
    
    func present(viewController : BaseVC){
        viewController.isPresented = true
        let nav = UINavigationController(rootViewController: viewController)
        self.present(nav, animated: true, completion: nil)
    }

    func presentLogout(viewController : BaseVC){
        viewController.isPresentLogout = true
        let nav = UINavigationController(rootViewController: viewController)
        self.present(nav, animated: true, completion: nil)
    }
    
    func push(viewController : BaseVC){
        viewController.isPresented = false
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func setupView(){
        
    }
    
    func hideKeyboard(){
        view.endEditing(true)
    }
    
    func localized(){
        
    }
}

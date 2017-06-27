//
//  WebViewPaymentVC.swift
//  gv24App
//
//  Created by dinhphong on 6/27/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class WebviewPaymentVC: BaseVC {
    
    
    let webView: UIWebView = {
        let wb = UIWebView()
        wb.translatesAutoresizingMaskIntoConstraints = false
        return wb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func setupView() {
        super.setupView()
        view.addSubview(webView)
        
        view.addConstraintWithFormat(format: "H:|[v0]|", views: webView)
        view.addConstraintWithFormat(format: "V:|[v0]|", views: webView)
        
        
    }
    
    
}

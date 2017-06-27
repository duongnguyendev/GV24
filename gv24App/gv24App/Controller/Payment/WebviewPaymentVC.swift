//
//  WebViewPaymentVC.swift
//  gv24App
//
//  Created by dinhphong on 6/27/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
class WebviewPaymentVC: BaseVC, UIWebViewDelegate {
    var gstrUrl: String?
    var token_code: String?
    
    lazy var webView: UIWebView = {
        let wb = UIWebView()
        wb.translatesAutoresizingMaskIntoConstraints = false
        wb.delegate = self
        return wb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ngân lượng"
        let url = URL(string: gstrUrl!)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
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
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let currentUrl = webView.stringByEvaluatingJavaScript(from: "window.location.href")
        if currentUrl == RETURN_URL{
            self.showAlertWith(message: "Thanh toán thành công", completion: {
                self.dismiss(animated: true, completion: nil)
            })
        }else{
        }
    }
    //MARK: - Show Message
    func showAlertWith(message: String, completion: @escaping (()->())){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (nil) in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }

}

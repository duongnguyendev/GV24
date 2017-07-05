//
//  WebviewRechargeOnlineVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 7/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class WebviewRechargeOnlineVC: WebviewPaymentVC {

    var billId : String?
    var key : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func webViewDidFinishLoad(_ webView: UIWebView) {
        let currentUrl = webView.stringByEvaluatingJavaScript(from: "window.location.href")
        if currentUrl == RETURN_URL{
            self.loadingView.show()
            handleSecConfirmWith()
        }else{
            
        }
    }
    func handleSecConfirmWith(){
        PaymentService.shared.chargeOnlineSeConfirm(billId: self.billId!, key: self.key!) { (returnKey, error) in
            if error != nil{
                self.showAlertWith(message: LanguageManager.shared.localized(string: error!)!, completion: {
                    self.loadingView.close()
                    self.dismiss(animated: true, completion: nil)
                })
            }else{
                self.handleThiConfirmWith(key: returnKey!)
            }
        }
    }
    func handleThiConfirmWith(key: String){
        PaymentService.shared.chargeOnlineThiConfirm(billId: billId!, key: key) { (error) in
            self.loadingView.close()
            if error != nil{
                self.showAlertWith(message:error!, completion: {
                    self.dismiss(animated: true, completion: nil)
                })
            }else{
                self.showAlertWith(message:LanguageManager.shared.localized(string: "RechargeSuccessful")!, completion: {
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
    }

}

//
//  RechargeOnlineVC.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/28/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit

class RechargeOnlineVC: SendOrderVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupBackButton()
        mtfName.text = UserHelpers.currentUser?.name
        mtfTotalMoney.isEnabled = true
        mtfEmail.text = UserHelpers.currentUser?.email
        mtfPhone.text = UserHelpers.currentUser?.phone
        mtfAddress.text = UserHelpers.currentUser?.address?.name
    }
    
    override func handleSendButton(_ sender: UIButton) {
        let numberMoney = Double(mtfTotalMoney.text!)
        if numberMoney != nil && numberMoney! >= 2000.0 {
            self.loadingView.show()
            PaymentService.shared.chargeOnlineFiConfirm(number: numberMoney!, completion: { (billId, key, error) in
                if error != nil{
                    self.showAlertWith(message: error!, completion: {
                        self.loadingView.close()
                    })
                }else{
                    self.handleNganLuongRequestWith(billId: billId!, key: key!)
                }
            })
        }else{
            showAlertWith(message: LanguageManager.shared.localized(string: "PleaseEnterTheAmount")!, completion: {
                
            })
        }
        
    }
    func handleNganLuongRequestWith(billId: String, key: String){
        let params = parameters(merchent_id: MERCHANT_ID, merchent_password: MERCHANT_PASSWORD, merchent_email: MERCHANT_ACCOUNT, order_code: ORDER_CODE)
        ManagerAPI.postData(fromServer: MAIN_URL_PUBLIC, andInfo: params, completionHandler: { (resultDict) in
            self.loadingView.close()
            if let result = resultDict as? Dictionary<String, Any>{
                let response_code = result["response_code"] as? String
                if response_code == "00"{
                    let wvPaymentVC = WebviewRechargeOnlineVC()
                    wvPaymentVC.gstrUrl = result["checkout_url"] as? String
                    wvPaymentVC.token_code = result["token_code"] as? String
                    wvPaymentVC.billId = billId
                    wvPaymentVC.key = key
                    self.push(viewController: wvPaymentVC)
                }
            }
        }) { (error) in
            self.loadingView.close()
            self.showAlertWith(message: LanguageManager.shared.localized(string: "PaymentFailed")!, completion: {})
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

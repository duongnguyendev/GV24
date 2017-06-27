//
//  PaymentService.swift
//  gv24App
//
//  Created by dinhphong on 6/26/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import SwiftyJSON
class PaymentService: APIService {
    
    static let shared = PaymentService()
    
    func getWalletOwner(completion: @escaping ((Wallet?)->())){
        let url = "owner/getWallet"
        getWithToken(url: url) { (json, error) in
            if error == nil{
                let wallet = Wallet(jsonData: json!)
                completion(wallet)
            }else{
                completion(nil)
            }
        }
    }
    
    func paymentGv247(billId: String,completion: @escaping ((Bool?)->())){
        let url = "payment/payBillGV"
        let params = ["billId": billId]
        postWithTokenUrl(url: url, parameters: params) { (json, error) in
            if error == nil{
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    func paymentOnline(){
        
    }
}

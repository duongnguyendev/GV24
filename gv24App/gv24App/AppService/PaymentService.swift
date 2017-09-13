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
                guard let jsonData = json else {return}
                let wallet = Wallet(jsonData: jsonData)
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
    func paymentOnlineCofirm(billId: String,completion: @escaping ((Bool?)->())){
        let url = "payment/payOnlineConfirm"
        let params = ["billId": billId]
        postWidthToken(url: url, parameters: params) { (json, error) in
            if error == nil{
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    func paymentOnline(billId: String,completion: @escaping ((Bool?)->())){
        let url = "payment/payOnline"
        let params = ["billId": billId]
        postWidthToken(url: url, parameters: params) { (json, error) in
            if error == nil{
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    func paymentMoney(billId: String,completion: @escaping ((Bool?)->())){
        let url = "payment/payDirectly"
        let params = ["billId": billId]
        postWithTokenUrl(url: url, parameters: params) { (json, error) in
            if error == nil{
                completion(true)
            }else{
                completion(false)
            }
        }

    }
    func chargeOnlineFiConfirm(number: Double, completion: @escaping ((String?, String?, String?)->())){
        let url = "payment/chargeOnlineFiConfirm"
        let params = ["price": number]
        postWidthToken(url: url, parameters: params) { (jsonData, error) in
            if error != nil{
                completion(nil, nil, error)
            }else{
                let bill = jsonData?["bill"].string
                let key = jsonData?["key"].string
                completion(bill, key, nil)
            }
        }
    }
    func chargeOnlineSeConfirm(billId : String, key: String, completion: @escaping ((String?, String?)->())){
        let url = "payment/chargeOnlineSecConfirm"
        let header = ["hbbgvauth": UserHelpers.token, "hbbgvaccesskey":key]
        let params = ["billId": billId]
        post(url: url, parameters: params, header: header) { (jsonData, error) in
            if error != nil{
                completion(nil, error)
            }else{
                let key = jsonData?["key"].string
                completion(key, nil)
            }
        }
    }
    
    func chargeOnlineThiConfirm(billId: String, key: String, completion: @escaping ((String?)->())){
        let url = "payment/chargeOnlineThiConfirm"
        let header = ["hbbgvauth": UserHelpers.token, "hbbgvaccesskey":key]
        let params = ["billId": billId]
        post(url: url, parameters: params, header: header) { (jsonData, error) in
            if error != nil{
                completion(error)
            }else{
                completion(nil)
            }
        }
    }
}

//
//  AppService.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 4/27/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Photos

typealias ResponseCompletion = (JSON?, String?) -> ()

class APIService: NSObject {
    
    func sendBackToLogin() {
        if let appDelegate = UIApplication.shared.delegate {
            let alertController = UIAlertController.init(title: LanguageManager.shared.localized(string: "WarningTitle"), message: LanguageManager.shared.localized(string: "WarningDescription"), preferredStyle: .alert)
            alertController.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                UserHelpers.logOut()
                UIView.transition(with: appDelegate.window!!, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                    appDelegate.window??.rootViewController = UINavigationController.init(rootViewController: SignInVC())
                }, completion: nil)
            }))
            appDelegate.window??.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func post(url : String, parameters: Parameters?, header: HTTPHeaders, completion: @escaping (ResponseCompletion)){
        
        if !(NetworkStatus.sharedInstance.reachabilityManager?.isReachable)!{
            completion(nil, LanguageManager.shared.localized(string: "NoInternetConnection"))
            return
        }
        
        Alamofire.request(self.urlFrom(request: url), method: .post, parameters: parameters, headers: header).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].bool
                if !status!{
                    if let message = json["message"].string{
                        if message == "UNAUTHORIZED" {
                            self.sendBackToLogin()
                            //completion(nil, message)
                        } else {
                            completion(nil, message)
                        }
                    }
                }else{
                    completion(json["data"], nil)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
                print(error)
            }
        }
    }
    
    //MARK: - POST
    func postWidthToken(url : String, parameters: Parameters, completion: @escaping (ResponseCompletion)){
        if !(NetworkStatus.sharedInstance.reachabilityManager?.isReachable)!{
            completion(nil, LanguageManager.shared.localized(string: "NoInternetConnection"))
            return
        }
        if let token = UserHelpers.token {
            let header : HTTPHeaders = ["hbbgvauth": token]
            
            Alamofire.request(self.urlFrom(request: url), method: .post, parameters: parameters, headers: header).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let status = json["status"].bool
                    if !status!{
                        if let message = json["message"].string{
                            if message == "UNAUTHORIZED" {
                                //completion(nil, message)
                                self.sendBackToLogin()
                            } else {
                                completion(nil, message)
                            }
                        }
                    }else{
                        completion(json["data"], nil)
                    }
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                    print(error)
                }
            }
        }
    }
    
    func postWithTokenUrl(url : String, parameters: Parameters, completion: @escaping (ResponseCompletion)){
        if !(NetworkStatus.sharedInstance.reachabilityManager?.isReachable)!{
            completion(nil, LanguageManager.shared.localized(string: "NoInternetConnection"))
            return
        }
        
        if let token = UserHelpers.token {
            let header : HTTPHeaders = ["hbbgvauth": token]
            Alamofire.request(self.urlFrom(request: url), method: .post, parameters: parameters,encoding:JSONEncoding.default, headers: header).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let status = json["status"].bool
                    if !status!{
                        if let message = json["message"].string{
                            if message == "UNAUTHORIZED" {
                                self.sendBackToLogin()
                                //completion(nil, message)
                            } else {
                                completion(nil, message)
                            }
                        }
                    }else{
                        completion(json["data"], nil)
                    }
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                    print(error)
                }
            }
            
        }
    }
    
    func postWithUrl(url : String, parameters: Parameters, completion: @escaping (ResponseCompletion)){
        if !(NetworkStatus.sharedInstance.reachabilityManager?.isReachable)!{
            completion(nil, LanguageManager.shared.localized(string: "NoInternetConnection"))
            return
        }
        Alamofire.request(self.urlFrom(request: url), method: .post, parameters: parameters,encoding:JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].bool
                if !status!{
                    if let message = json["message"].string{
                        if message == "UNAUTHORIZED" {
                            self.sendBackToLogin()
                            //completion(nil, message)
                        } else {
                            completion(nil, message)
                        }
                    }
                }else{
                    completion(json["data"], nil)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
                print(error)
            }
        }
        
    }
    func post(url : String, parameters: Dictionary<String, Any>, completion: @escaping (ResponseCompletion)){
        if !(NetworkStatus.sharedInstance.reachabilityManager?.isReachable)!{
            completion(nil, LanguageManager.shared.localized(string: "NoInternetConnection"))
            return
        }
        Alamofire.request(self.urlFrom(request: url), method: .post, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].bool
                if !status!{
                    if let message = json["message"].string{
                        if message == "UNAUTHORIZED" {
                            self.sendBackToLogin()
                            //completion(nil, message)
                        } else {
                            completion(nil, message)
                        }
                    }
                }else{
                    completion(json["data"], nil)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
                print(error)
            }
        }
    }
    
    func postMultipart(url : String, image: UIImage?, name: String?, parameters: Dictionary<String, String>, completion: @escaping (ResponseCompletion)){
        if !(NetworkStatus.sharedInstance.reachabilityManager?.isReachable)!{
            completion(nil, LanguageManager.shared.localized(string: "NoInternetConnection"))
            return
        }
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                if let imageUpload = image{
                    if let imageData = UIImagePNGRepresentation(imageUpload){
                        multipartFormData.append(imageData, withName: name!, fileName: "\(name!).jpeg", mimeType: "image/jpeg")
                    }
                }
                for (key,value) in parameters{
                    multipartFormData.append((value.data(using: .utf8))!, withName: key)
                }
        },
            to: urlFrom(request: url),
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        guard case let .success(jsonData) = response.result else {
                            return completion(nil, response.error?.localizedDescription)
                        }
                        let json = JSON(jsonData)
                        let status = json["status"].boolValue
                        if !status {
                            if let message = json["message"].string{
                                if message == "UNAUTHORIZED" {
                                    self.sendBackToLogin()
                                    //completion(nil, message)
                                } else {
                                    completion(nil, message)
                                }
                            } else {
                                completion(nil, "unknow error")
                            }
                            
                        }else{
                            completion(json["data"], nil)
                        }
                    }
                    
                case .failure(let encodingError):
                    completion(nil, encodingError.localizedDescription)
                }
        }
        )
    }
    func postMultipartWithToken(url : String, image: UIImage?, name: String?, parameters: Dictionary<String, String>, completion: @escaping (ResponseCompletion)){
        if !(NetworkStatus.sharedInstance.reachabilityManager?.isReachable)!{
            completion(nil, LanguageManager.shared.localized(string: "NoInternetConnection"))
            return
        }
        
        if let token = UserHelpers.token {
            let header : HTTPHeaders = ["hbbgvauth": token]
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    if image != nil{
                        if let imageData = UIImagePNGRepresentation(image!){
                            multipartFormData.append(imageData, withName: name!, fileName: "\(name!).jpeg", mimeType: "image/jpeg")
                        }
                    }
                    for (key,value) in parameters{
                        multipartFormData.append((value.data(using: .utf8))!, withName: key)
                    }
            },
                to: urlFrom(request: url),
                method: .post,
                headers: header,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            let json = JSON(response.value as Any)
                            let status = json["status"].bool
                            if !status!{
                                if let message = json["message"].string{
                                    if message == "UNAUTHORIZED" {
                                        self.sendBackToLogin()
                                        //completion(nil, message)
                                    } else {
                                        completion(nil, message)
                                    }
                                }
                            }else{
                                completion(json["data"], nil)
                            }
                        }
                    case .failure(let encodingError):
                        completion(nil, encodingError.localizedDescription)
                    }
            })
        }
        
    }
    
    func putWithToken(url: String,parameters: Parameters, completion: @escaping (ResponseCompletion)){
        if !(NetworkStatus.sharedInstance.reachabilityManager?.isReachable)!{
            completion(nil, LanguageManager.shared.localized(string: "NoInternetConnection"))
            return
        }
        
        if let token = UserHelpers.token {
            let header : HTTPHeaders = ["hbbgvauth": token]
            Alamofire.request(self.urlFrom(request: url), method: .put, parameters: parameters, headers: header).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let status = json["status"].bool
                    if !status!{
                        if let message = json["message"].string{
                            if message == "UNAUTHORIZED" {
                                self.sendBackToLogin()
                                //completion(nil, message)
                            } else {
                                completion(nil, message)
                            }
                        }
                    }else{
                        completion(json["data"], nil)
                    }
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                    print(error)
                }
                
            }
        }
    }
    
    func putMultipartWithToken(url : String, image: UIImage?, name: String?, parameters: Dictionary<String, String>, completion: @escaping (ResponseCompletion)){
        if !(NetworkStatus.sharedInstance.reachabilityManager?.isReachable)!{
            completion(nil, LanguageManager.shared.localized(string: "NoInternetConnection"))
            return
        }
        
        if let token = UserHelpers.token {
            let header : HTTPHeaders = ["hbbgvauth": token]
            
            Alamofire.upload(
                multipartFormData: { multipartFormData in
                    if image != nil{
                        if let imageData = UIImagePNGRepresentation(image!){
                            multipartFormData.append(imageData, withName: name!, fileName: "\(name!).jpeg", mimeType: "image/jpeg")
                        }
                    }
                    
                    for (key,value) in parameters{
                        multipartFormData.append((value.data(using: .utf8))!, withName: key)
                    }
            },
                to: urlFrom(request: url),
                method: .put,
                headers: header,
                encodingCompletion: { encodingResult in
                    switch encodingResult {
                    case .success(let upload, _, _):
                        upload.responseJSON { response in
                            let json = JSON(response.value as Any)
                            let status = json["status"].bool
                            if !status!{
                                if let message = json["message"].string{
                                    if message == "UNAUTHORIZED" {
                                        self.sendBackToLogin()
                                        //completion(nil, message)
                                    } else {
                                        completion(nil, message)
                                    }
                                }
                            }else{
                                completion(json["data"], nil)
                            }
                        }
                    case .failure(let encodingError):
                        completion(nil, encodingError.localizedDescription)
                    }
            })
        }
    }
    
    //MARK: - GET
    func get(url : String, completion:@escaping (ResponseCompletion)){
        if !(NetworkStatus.sharedInstance.reachabilityManager?.isReachable)!{
            completion(nil, LanguageManager.shared.localized(string: "NoInternetConnection"))
            return
        }
        Alamofire.request(self.urlFrom(request: url)).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].bool
                if !status!{
                    if let message = json["message"].string{
                        if message == "UNAUTHORIZED" {
                            self.sendBackToLogin()
                            //completion(nil, message)
                        } else {
                            completion(nil, message)
                        }
                    }
                }else{
                    completion(json["data"], nil)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
                print(error)
            }
        }
    }
    func getWithtoken(url: String, params : Parameters,  completion:@escaping (ResponseCompletion)){
        if !(NetworkStatus.sharedInstance.reachabilityManager?.isReachable)!{
            completion(nil, LanguageManager.shared.localized(string: "NoInternetConnection"))
            return
        }
        
        if let token = UserHelpers.token {
            let header : HTTPHeaders = ["hbbgvauth": token]
            Alamofire.request(urlFrom(request: url), parameters: params, headers: header).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let status = json["status"].bool
                    if !status!{
                        if let message = json["message"].string{
                            if message == "UNAUTHORIZED" {
                                self.sendBackToLogin()
                                //completion(nil, message)
                            } else {
                                completion(nil, message)
                            }
                        }
                    }else{
                        completion(json["data"], nil)
                    }
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                    print(error)
                }
                
            }
        }
    }
    
    func getWithToken(url : String, completion:@escaping (ResponseCompletion)){
        if !(NetworkStatus.sharedInstance.reachabilityManager?.isReachable)!{
            completion(nil, LanguageManager.shared.localized(string: "NoInternetConnection"))
            return
        }
        
        if let token = UserHelpers.token {
            let header : HTTPHeaders = ["hbbgvauth": token]
            Alamofire.request(self.urlFrom(request: url), headers: header).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let status = json["status"].bool
                    if !status!{
                        if let message = json["message"].string{
                            if message == "UNAUTHORIZED" {
                                self.sendBackToLogin()
                                //completion(nil, message)
                            } else {
                                completion(nil, message)
                            }
                        }
                    }else{
                        completion(json["data"], nil)
                    }
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                    print(error)
                }
            }
        }
    }
    
    func getWithToken(url: String, params : Parameters, completion:@escaping (ResponseCompletion)){
        if !(NetworkStatus.sharedInstance.reachabilityManager?.isReachable)!{
            completion(nil, LanguageManager.shared.localized(string: "NoInternetConnection"))
            return
        }
        
        if let token = UserHelpers.token {
            let header : HTTPHeaders = ["hbbgvauth": token]
            
            Alamofire.request(self.urlFrom(request: url),parameters: params, headers: header).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let status = json["status"].bool
                    if !status!{
                        if let message = json["message"].string{
                            if message == "UNAUTHORIZED" {
                                self.sendBackToLogin()
                                //completion(nil, message)
                            } else {
                                completion(nil, message)
                            }
                        }
                    }else{
                        completion(json["data"], nil)
                    }
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                    print(error)
                }
            }
        }
    }
    
    func deleteWithToken(url: String,parameters: Dictionary<String, String>,completion:@escaping (ResponseCompletion)){
        if !(NetworkStatus.sharedInstance.reachabilityManager?.isReachable)!{
            completion(nil, LanguageManager.shared.localized(string: "NoInternetConnection"))
            return
        }
        
        if let token = UserHelpers.token {
            let header: HTTPHeaders = ["hbbgvauth": token]
            Alamofire.request(self.urlFrom(request: url), method: .delete, parameters: parameters,encoding: JSONEncoding.default,headers: header).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let status = json["status"].bool
                    if !status!{
                        if let message = json["message"].string{
                            if message == "UNAUTHORIZED" {
                                self.sendBackToLogin()
                                //completion(nil, message)
                            } else {
                                completion(nil, message)
                            }
                        }
                    }else{
                        completion(json["data"], nil)
                    }
                case .failure(let error):
                    completion(nil, error.localizedDescription)
                    print(error)
                }
            }
        }
    }
    
    func urlFrom(request: String) -> String{
        return domain + request
    }
    
    var domain : String{
        return LanguageManager.shared.localized(string: "domainGV24")!
    }
}


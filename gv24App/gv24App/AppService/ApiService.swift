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
    
    //MARK: - POST
    func postWidthToken(url : String, parameters: Parameters, completion: @escaping (ResponseCompletion)){
        
        let header : HTTPHeaders = ["hbbgvauth": UserHelpers.token]
        Alamofire.request(self.urlFrom(request: url), method: .post, parameters: parameters, headers: header).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
                print(error)
            }
        }
    }
    func post(url : String, parameters: Dictionary<String, Any>, completion: @escaping (ResponseCompletion)){
        Alamofire.request(self.urlFrom(request: url), method: .post, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].bool
                if !status!{
                    if let message = json["message"].string{
                        completion(nil, message)
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
                        let json = JSON(response.value as Any)
                        let status = json["status"].bool
                        if !status!{
                            if let message = json["message"].string{
                                completion(nil, message)
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
        
        let header : HTTPHeaders = ["hbbgvauth": UserHelpers.token]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                if let imageData = UIImagePNGRepresentation(image!){
                    multipartFormData.append(imageData, withName: name!, fileName: "\(name!).jpeg", mimeType: "image/jpeg")
                }
                for (key,value) in parameters{
                    multipartFormData.append((value.data(using: .utf8))!, withName: key)
                }
        },
            to: urlFrom(request: url),
            headers: header,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        let json = JSON(response.value as Any)
                        let status = json["status"].bool
                        if !status!{
                            if let message = json["message"].string{
                                completion(nil, message)
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
    //MARK: - GET
    func get(url : String, completion:@escaping (ResponseCompletion)){
        Alamofire.request(self.urlFrom(request: url)).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].bool
                if !status!{
                    if let message = json["message"].string{
                        completion(nil, message)
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
    
    func getWithToken(url : String, completion:@escaping (ResponseCompletion)){
        let header : HTTPHeaders = ["hbbgvauth": UserHelpers.token]
        Alamofire.request(self.urlFrom(request: url), headers: header).responseJSON { (response) in
    
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].bool
                if !status!{
                    if let message = json["message"].string{
                        completion(nil, message)
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
    func urlFrom(request: String) -> String{
        return domain + request
    }
    var domain : String{
        return LanguageManager.shared.localized(string: "domainGV24")!
    }
}


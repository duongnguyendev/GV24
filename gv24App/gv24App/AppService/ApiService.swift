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

class APIService: NSObject {
    static let shared = APIService()
    func post(url : String, parameters: Parameters, completion: @escaping ((JSON?, Error?)->())){
        
        Alamofire.request(self.urlFrom(request: url), method: .post, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json, nil)
            case .failure(let error):
                completion(nil, error)
                print(error)
            }
        }
    }
    func get(url : String, completion:@escaping ((JSON?,Error?)->())){
        Alamofire.request(self.urlFrom(request: url)).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json, nil)
            case .failure(let error):
                completion(nil, error)
                print(error)
            }
        }
        
    }
    
    func upload(images: UIImage..., parameters : Dictionary<String, String>?, url: String, completion:@escaping ((JSON?,Error?)->())){
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for (index, image) in images.enumerated(){
                    if let imageData = UIImagePNGRepresentation(image){
                        multipartFormData.append(imageData, withName: "image\(index)", fileName: "image\(index).jpeg", mimeType: "image/jpeg")
                    }
                }
                if let params = parameters{
                    for (key,value) in params{
                        multipartFormData.append((value.data(using: .utf8))!, withName: key)
                    }
                }
        },
            to: urlFrom(request: url),
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        let json = JSON(response)
                        completion(json, nil)
                    }
                case .failure(let encodingError):
                    completion(nil, encodingError)
                }
        }
        )
    }
    
    func upload(datas: Data..., parameters : Dictionary<String, String>?, url: String, completion:@escaping ((JSON?,Error?)->())){
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for (index, data) in datas.enumerated(){
                    multipartFormData.append(data, withName: "data\(index)")
                    if let params = parameters{
                        for (key,value) in params{
                            multipartFormData.append((value.data(using: .utf8))!, withName: key)
                        }
                    }
                }
                if let params = parameters{
                    for (key,value) in params{
                        multipartFormData.append((value.data(using: .utf8))!, withName: key)
                    }
                }
        },
            to: urlFrom(request: url),
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        let json = JSON(response)
                        completion(json, nil)
                    }
                case .failure(let encodingError):
                    completion(nil, encodingError)
                }
        }
        )
    }
    
    func urlFrom(request: String) -> String{
        return LanguageManager.shared.localized(string: "domainGV24")! + request
    }
}


//
//  UserService.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/22/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire
import Firebase

class UserService: APIService {
    
    static let shared = UserService()
    
    func getMaidAround(location : CLLocationCoordinate2D, completion : @escaping (([MaidProfile]?, String?) -> ())){
        let url = "more/getAllMaids?lat=\(location.latitude)&lng=\(location.longitude)"
        get(url: url) { (response, error) in
            if error == nil {
                completion(self.getMaidProfileFrom(json: response!), nil)
            }else{
                completion(nil, error)
            }
        }
    }
    
    func logIn(userName : String, password: String, completion : @escaping ((User?, String?, String?)->())){
        let url = "auth/login"
        var params : Dictionary<String, String> = ["username": userName, "password": password]
        if let token = FIRInstanceID.instanceID().token(){
            params["device_token"] = token + "@//@ios"
        }
        postMultipart(url: url, image: nil, name: nil, parameters: params) { (jsonData, error) in
            if error == nil{
                let token = jsonData?["token"].string
                let user = User(jsonData: (jsonData?["user"])!)
                completion(user,token , nil)
            }else{
                completion(nil, nil, error)
            }
        }
    }
    
    func getMyInfo(completion : @escaping ((User?, String?)->())){
        let url = "owner/getMyInfo"
        getWithToken(url: url) { (jsonData, error) in
            if error == nil{
                let user = User(jsonData: jsonData!)
                completion(user,nil)
            }else{
                completion(nil, error)
            }
        }
    }
    func loginSocial(userInfo : Dictionary<String, String>, completion : @escaping ((User?, String?, String?)->())){
        let url = "auth/thirdLogin"
        let params : Dictionary<String, String> = ["id": userInfo["id"]!,
                                                   "token": userInfo["token"]!,
                                                   "device_token" : FIRInstanceID.instanceID().token()! + "@//@ios"]
        postMultipart(url: url, image: nil, name: nil, parameters: params) { (response, error) in
            if error == nil{
                let token = response?["token"].string
                let user = User(jsonData: (response?["user"])!)
                completion(user,token , nil)
            }else{
                completion(nil, nil, error)
            }        }
    }
    func signUpSocical(userInfo : Dictionary<String, String>, completion : @escaping ((User?, String?, String?)->())){
        var params = userInfo
        let url = "auth/thirdRegister"
        params["device_token"] = FIRInstanceID.instanceID().token()! + "@//@ios"
        
        postMultipart(url: url, image: nil, name: nil, parameters: params) { (jsonData, error) in
            if error == nil{
                let token = jsonData?["token"].string
                let user = User(jsonData: (jsonData?["user"])!)
                completion(user,token , nil)
            }else{
                completion(nil, nil, error)
            }
        }
        
    }
    func getComments(user : User?, page : Int?, completion:@escaping (([Comment]?, Int?, Int?, String?)->())){
        
        var url = "maid/getComment"
        
        if user == nil {
            url = url + "?id=\((UserHelpers.currentUser?.userId)!)"
        }else{
            url = url + "?id=\((user?.userId)!)"
        }
        if page != nil{
            url = url + "&page=\(page! + 1)"
        }
        getWithToken(url: url) { (jsonData, error) in
            if error == nil{
                let page = jsonData?["page"].int
                let pages = jsonData?["pages"].int
                completion(self.getCommentsFrom(json: (jsonData?["docs"])!), page, pages, nil)
            }else{
                completion(nil, nil, nil, error)
            }
        }
    }
    
    func filter(params : Parameters, location : CLLocationCoordinate2D, completion : @escaping (([MaidProfile]?, String?) -> ())){
        var url = "more/getAllMaids?lat=\(location.latitude)&lng=\(location.longitude)"
        var paramsString : String = ""
        for (key,value) in params{
                paramsString = paramsString + "&\(key)=\(value)"
        }
        url = url + paramsString
        
        get(url: url) { (jsonData, error) in
            if error == nil {
                completion(self.getMaidProfileFrom(json: jsonData!), nil)
            }else{
                completion(nil, error)
            }
        }
        
    }
    
    func register(info: Dictionary<String, String>, avatar: UIImage, completion : @escaping ((User?, String?, String?)->())){
        let url = "auth/register"
        var registerInfo = info
        registerInfo["device_token"] = FIRInstanceID.instanceID().token()! + "@//@ios"
        postMultipart(url: url, image: avatar, name: "image", parameters: registerInfo) { (jsonData, error) in
            if error == nil{
                let token = jsonData?["token"].string
                let user = User(jsonData: (jsonData?["user"])!)
                completion(user,token , nil)
            }else{
                completion(nil, nil, error)
            }
        }
    }
    
    func updateProfile(info: Dictionary<String, String>, avatar: UIImage?, completion : @escaping ((User?, String?)->())){
        let url = "owner/update"
        var imageName : String?
        if avatar != nil{
            imageName = "image"
        }
        putMultipartWithToken(url: url, image: avatar, name: imageName, parameters: info) { (jsonData, error) in
            if error == nil{
                let user = User(jsonData: jsonData!)
                completion(user , nil)
            }else{
                completion(nil, error)
            }
        }
    }
    func forgotPassword(userName : String, email: String, completion:@escaping ((_ error: String?)->())){
        let url = "more/ownerForgotPassword"
        let params : Dictionary<String, String> = ["username": userName, "email": email]
        postWithUrl(url: url, parameters: params) { (jsonData, error) in
            if error != nil{
                completion(error)
            }else{
                completion(nil)
            }

        }
    }
    
    func report(maidId: String, content: String, completion: @escaping ((String?)->())){
        let url = "owner/report"
        let params = ["toId":maidId, "content": content]
        postWidthToken(url: url, parameters: params) { (jsonData, error) in
            if error == nil{
                completion(nil)
            }else{
                completion(error)
            }
        }
    }
    func checkStatus(completion: @escaping ((String?)->())){
        let url = "owner/statistical"
        getWithToken(url: url) { (jsonData, error) in
            completion(error)
        }
    }
    
    private func getMaidProfileFrom(json : JSON) -> [MaidProfile]?{
        if let data = json.array{
            var listMaidProfile : [MaidProfile] = [MaidProfile]()
            for maidData in data {
                listMaidProfile.append(MaidProfile(jsonData: maidData))
            }
            return listMaidProfile
        }
        
        return nil
    }
    
    private func getCommentsFrom(json: JSON) ->[Comment]?{
        
        if let data = json.array{
            var listComment : [Comment] = [Comment]()
            for commentData in data{
                listComment.append(Comment(jsonData: commentData))
            }
            return listComment
        }
        
        return nil
    }
    
}

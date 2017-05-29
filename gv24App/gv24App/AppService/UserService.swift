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
        let params : Dictionary<String, String> = ["username": userName, "password": password]
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
    
    func getComments(user : User, page : Int?){
        var url = "maid/getComment?id=\((user.userId)!)"
        if page != nil{
            url = url + "&page=\(page!)"
        }
        
        getWithToken(url: url) { (jsonData, error) in
            if error == nil{
                
            }else{
            
            }
        }
    }
    
    func register(info: Dictionary<String, String>, avatar: UIImage, completion : @escaping ((User?, String?, String?)->())){
        let url = "auth/register"
        postMultipart(url: url, image: avatar, name: "image", parameters: info) { (jsonData, error) in
            if error == nil{
                let token = jsonData?["token"].string
                let user = User(jsonData: (jsonData?["user"])!)
                completion(user,token , nil)
            }else{
                completion(nil, nil, error)
            }
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
    
    
    
}

//
//  MoreService.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/21/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import Firebase

class MoreService: APIService {
    static let shared = MoreService()
    
    func getContact(completion : @escaping ((Contact?, String?) -> ())){
        let url = "more/getContact"
        
        getWithToken(url: url) { (jsonData, error) in
            if error != nil{
                completion(nil, error)
            }else{
                let contact = Contact(jsonData: jsonData!)
                completion(contact, nil)
            }
        }
    }
    func getAbout(completion : @escaping ((_ htmlString : String?, _ error: String?)->())){
        let url = "more/getGV24HInfo?id=000000000000000000000001"
        get(url: url) { (jsonData, error) in
            if error != nil{
                completion(nil, error)
            }else{
                let htmlString = jsonData?["content"].string
                completion(htmlString, nil)
            }
        }
    }
    func getTerms(completion : @escaping ((_ htmlString : String?, _ error: String?)->())){
        let url = "more/getGV24HInfo?id=000000000000000000000002"
        get(url: url) { (jsonData, error) in
            if error != nil{
                completion(nil, error)
            }else{
                let htmlString = jsonData?["content"].string
                completion(htmlString, nil)
            }
        }
    }
    func handleNotification(isOn: Bool, completion:@escaping ((Bool)->())){
        var url = "owner/offAnnouncement"
        var params = Dictionary<String, String>()
        if isOn{
            url = "owner/onAnnouncement"
            params[""] = FIRInstanceID.instanceID().token()! + "@//@ios"
        }
        postWidthToken(url: url, parameters: params) { (jsonData, error) in
            if error != nil{
                completion(false)
            }else{
                completion(true)
            }
        }
    }
}

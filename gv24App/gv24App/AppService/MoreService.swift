//
//  MoreService.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/21/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit


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
}

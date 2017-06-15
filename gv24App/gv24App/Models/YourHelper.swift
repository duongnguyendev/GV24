//
//  YourHelper.swift
//  gv24App
//
//  Created by Macbook Solution on 6/8/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import SwiftyJSON
class YourHelper: Entity {
    var id: ID?
    var times: [String]?
    
    override init() {
        super.init()
    }
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.id = ID(jsonData: jsonData["_id"])
        self.times = jsonData["times"].array?.map{ return String( describing: $0 ) } ?? []
    }
}
class ID: Entity{
    var id: String?
    var workInfo: WorkInfo?
    var maidInfo: MaidInfo?
    override init() {
        super.init()
    }
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.id = jsonData["_id"].string ?? ""
        self.workInfo = WorkInfo(jsonData: jsonData["work_info"])
        self.maidInfo = MaidInfo(json: jsonData["info"])
    }
    
    struct MaidInfo {
        let username: String?
        let email: String?
        let phone: String?
        let image: String?
        let name: String?
        let age: Int?
        let gender: Int?
        let address: Address?
        
        init(json: JSON) {
            self.username = json["username"].string ?? ""
            self.email = json["email"].string ?? ""
            self.phone = json["phone"].string ?? ""
            self.image = json["image"].string ?? ""
            self.name = json["name"].string ?? ""
            self.age = json["age"].int ?? 0
            self.gender = json["gender"].int ?? 0
            self.address = Address(jsonData: json["address"])
        }
    }
}


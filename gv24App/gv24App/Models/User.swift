//
//  User.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/22/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: Entity {
    var userId : String?
    var userName : String?
    var name : String?
    var email : String?
    var phone : String?
    var avatarUrl : String?
    var address : Address?
    var gender : Int?
    override init() {
        super.init()
    }
    override init(jsonData: JSON) {
        super.init()
        self.userId = jsonData["_id"].string
        self.userName = jsonData["info"]["username"].string
        self.name = jsonData["info"]["name"].string
        self.email = jsonData["info"]["email"].string
        self.phone = jsonData["info"]["phone"].string
        self.avatarUrl = jsonData["info"]["image"].string
        self.gender = jsonData["info"]["gender"].int
        self.address = Address(jsonData: jsonData["info"]["address"])
        
    }
}
class MaidProfile : User {
    
    var workInfo : WorkInfo?
    override init(jsonData data: JSON) {
        super.init(jsonData: data)
        self.workInfo = WorkInfo(jsonData: data["work_info"])
    }
}


//
//  Contact.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/21/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import SwiftyJSON

class Contact: Entity {
    var id : String?
    var email : String?
    var phone : String?
    var note : String?
    var address : String?
    var name : String?
    
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.id = jsonData["_id"].string
        self.email = jsonData["email"].string
        self.phone = jsonData["phone"].string
        self.note = jsonData["note"].string
        self.address = jsonData["address"].string
        self.name = jsonData["name"].string
    }
}

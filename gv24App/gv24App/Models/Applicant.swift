//
//  Applicant.swift
//  gv24App
//
//  Created by Macbook Solution on 6/2/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import SwiftyJSON
class Applicant: Entity{
    var id: String?
    var request: [Request]?
    override init() {
        super.init()
    }
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        id = jsonData["_id"].string ?? ""
        self.request = jsonData["request"].array?.map { return Request(jsonData: $0) } ?? []
    }
}
class Request: Entity {
    var time: String?
    var madid: MaidProfile?
    var id: String?
    
    override init(){
        super.init()
    }
    
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.time = jsonData["time"].string ?? ""
        self.id = jsonData["_id"].string ?? ""
        self.madid = MaidProfile(jsonData: jsonData["maid"])
    }
}

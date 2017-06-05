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
    var madid: Maid?
    override init(){
        super.init()
    }
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.time = jsonData["time"].string
        self.madid = Maid(jsonData: jsonData["maid"])
    }
}
class Maid: Entity{
    var madid: String?
    var work_info: WorkInfo?
    var info_request: InfoRequest?
    override init() {
        super.init()
    }
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.madid = jsonData["_id"].string ?? ""
        self.work_info = WorkInfo(json: jsonData["work_info"])
        self.info_request = InfoRequest(jsonData: jsonData["info"])
    }
    struct WorkInfo {
        let price: Int
        let evaluation_point: Int
        init(json: JSON) {
            self.price = json["price"].int ?? 0
            self.evaluation_point = json["evaluation_point"].int ?? 0
            
        }
    }
}
class InfoRequest: Entity {
    var username: String?
    var email: String?
    var phone: String?
    var image: String?
    var name: String?
    var age: String?
    var gender: String?
    var address: Address?
    override init(){
        super.init()
    }
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.username = jsonData["username"].string ?? ""
        self.email = jsonData["email"].string ?? ""
        self.phone = jsonData["phone"].string ?? ""
        self.image = jsonData["image"].string ?? ""
        self.name = jsonData["name"].string ?? ""
        self.age = jsonData["age"].string ?? ""
        self.gender = jsonData["gender"].string ?? ""
        self.address = Address(json: jsonData["address"])
    }
    struct Address {
        let name: String
        let lat: Double
        let lng: Double
        init(json: JSON) {
            self.name = json["name"].string ?? ""
            self.lat = json["coordinates"]["lat"].double ?? 0
            self.lng = json["coordinates"]["lng"].double ?? 0
        }
    }
}

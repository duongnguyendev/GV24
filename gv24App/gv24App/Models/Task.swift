//
//  TaskManage.swift
//  gv24App
//
//  Created by Macbook Solution on 5/29/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import SwiftyJSON

class Task: Entity{
    var id: String?
    var process: Process?
    var history: History?
    var stakeholder: Stakeholder?
    var info: Info?
    
    override init() {
        super.init()
    }
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        id = jsonData["_id"].string ?? ""
        self.process = Process(jsonData: jsonData["process"])
        self.history = History(jsonData: jsonData["history"])
        self.stakeholder = Stakeholder(jsonData: jsonData["stakeholders"])
        self.info = Info(jsonData: jsonData["info"])
    }
}
class Process: Entity{
    var id: String?
    var name: String?
    override init() {
        super.init()
    }
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.id = jsonData["_id"].string ?? ""
        self.name = jsonData["name"].string ?? ""
    }
}
class History: Entity{
    var createAt: String?
    var updateAt: String?
    override init() {
        super.init()
    }
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.createAt = jsonData["createAt"].string ?? ""
        self.updateAt = jsonData["updateAt"].string ?? ""
    }
}
class Stakeholder: Entity{
    var owner: String?
    var request: [Request]?
    var receivced: MaidProfile?
    
    override init() {
        super.init()
    }
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.owner = jsonData["owner"].string ?? ""
        self.request = jsonData["request"].array?.map { return Request(json: $0) } ?? []
        self.receivced = MaidProfile(jsonData: jsonData["received"])
    }
    struct Request {
        let maid: String?
        let time: String?
        init(json: JSON) {
            maid = json["maid"].string ?? ""
            time = json["time"].string ?? ""
        }
    }
}
class Info: Entity {
    var title: String?
    var package: Package?
    var work: Work?
    var desc: String?
    var price: NSNumber?
    var tool: Bool?
    var time: Time?
    var address: Address?
    
    override init() {
        super.init()
    }
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.title = jsonData["title"].string ?? ""
        self.package = Package(json: jsonData["package"])
        self.work = Work(json: jsonData["work"])
        self.desc = jsonData["description"].string ?? ""
        self.price = jsonData["price"].number ?? 0
        self.tool  = jsonData["tool"].bool ?? false
        self.time = Time(json: jsonData["time"])
        self.address = Address(jsonData: jsonData["address"])
    }
    struct Package {
        let id: String?
        let name: String?
        init(json: JSON) {
            self.id = json["_id"].string ?? ""
            self.name = json["name"].string ?? ""
        }
    }
    struct Work {
        let id: String
        let name: String
        let image: String
        init(json: JSON) {
            self.id = json["_id"].string ?? ""
            self.name = json["name"].string ?? ""
            self.image = json["image"].string ?? ""
        }
    }
    struct Time {
        let startAt: String
        let endAt: String
        let hour: NSNumber?
        
        init(json: JSON) {
            self.startAt = json["startAt"].string ?? ""
            self.endAt = json["endAt"].string ?? ""
            self.hour = json["hour"].number ?? 0
        }
    }
}

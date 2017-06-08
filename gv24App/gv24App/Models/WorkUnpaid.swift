//
//  WorkUnpaid.swift
//  gv24App
//
//  Created by Macbook Solution on 6/7/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class WorkUnpaid: Entity{
    var id: String?
    var price: Int?
    var period: String?
    var task: TaskUnpaid?
    
    override init(){
        super.init()
    }
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.id = jsonData["_id"].string ?? ""
        self.price = jsonData["price"].int ?? 0
        self.period = jsonData["period"].string ?? ""
        self.task = TaskUnpaid(jsonData: jsonData["task"])
    }
}
class TaskUnpaid: Entity {
    var id: String?
    var process: Process?
    var history: History?
    var check: CheckInOut?
    var stakeHolder: StakeholderUnpaid?
    var infoTask: TaskInfo?
    
    override init() {
        super.init()
    }
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        
        self.id = jsonData["_id"].string ?? ""
        self.process = Process(json: jsonData["process"])
        self.history = History(json: jsonData["history"])
        self.check = CheckInOut(json: jsonData["check"])
        self.stakeHolder = StakeholderUnpaid(jsonData: jsonData["stakeholders"])
        self.infoTask = TaskInfo(jsonData: jsonData["info"])
    }
    
    struct Process {
        let id: String?
        let name: String?
        
        init(json: JSON) {
            self.id = json["_id"].string ?? ""
            self.name = json["name"].string ?? ""
        }
    }
    struct History {
        let createAt: String?
        let updateAt: String?
        init(json: JSON) {
            self.createAt = json["createAt"].string ?? ""
            self.updateAt = json["updateAt"].string ?? ""
        }
    }
    struct CheckInOut {
        let checkIn: String?
        let checkOut: String?
        
        init(json: JSON) {
            self.checkIn = json["check_in"].string ?? ""
            self.checkOut = json["check_out"].string ?? ""
        }
    }
}
class StakeholderUnpaid: Entity {
    var owner: String?
    var received: ReceivedUnpaid?
    var request: [Request]?
    
    override init() {
        super.init()
    }
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.owner = jsonData["owner"].string ?? ""
        self.received = ReceivedUnpaid(jsonData: jsonData["received"])
        self.request = jsonData["request"].array?.map { return Request(json: $0) } ?? []
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
class ReceivedUnpaid: Entity{
    var id: String?
    var workInfo: WorkInfo?
    var infoUnpaid: InfoUnpaid?
    
    override init() {
        super.init()
    }
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
    }
    
    struct InfoUnpaid {
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
class TaskInfo: Entity {
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

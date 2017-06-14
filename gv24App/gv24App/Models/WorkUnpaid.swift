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

class TaskUnpaid: Task {
    var check: CheckInOut?
    
    override init() {
        super.init()
    }
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.check = CheckInOut(jsonData: jsonData["check"])

    }
}
class CheckInOut: Entity {
    var checkIn: String?
    var checkOut: String?
    
    override init() {
        super.init()
    }
    
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        
        self.checkIn = jsonData["check_in"].string ?? ""
        self.checkOut = jsonData["check_out"].string ?? ""
    }
}

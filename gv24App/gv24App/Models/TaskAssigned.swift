//
//  TaskAssigned.swift
//  gv24App
//
//  Created by Macbook Solution on 6/12/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import SwiftyJSON
class TaskAssigned: Task{
    var received: Receive?
    
    override init() {
        super.init()
    }
    
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.received = Receive(jsonData: jsonData["stakeholders"]["received"])
    }
}

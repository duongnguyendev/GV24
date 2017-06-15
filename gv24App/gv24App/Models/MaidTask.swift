//
//  MaidTask.swift
//  gv24App
//
//  Created by Macbook Solution on 6/9/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class MaidTask: Entity{
    var total: NSNumber?
    var page: NSNumber?
    var limit: NSNumber?
    var pages: NSNumber?
    var taks: [TaskUnpaid]?
    
    override init() {
        super.init()
    }
    
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.total = jsonData["total"].number ?? 0
        self.page = jsonData["page"].number ?? 0
        self.limit = jsonData["limit"].number ?? 0
        self.pages = jsonData["pages"].number ?? 0
        self.taks = jsonData["docs"].array?.map{ return TaskUnpaid(jsonData: $0) } ?? []
    }
    
}

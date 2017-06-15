//
//  TaskDone.swift
//  gv24App
//
//  Created by Macbook Solution on 6/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import SwiftyJSON
class TaskHistory: Entity{
    var total: Int?
    var limit: Int?
    var page: Int?
    var pages: Int?
    var docs: [Task]?
    override init() {
        super.init()
    }
    
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.total = jsonData["total"].int ?? 0
        self.limit = jsonData["limit"].int ?? 0
        self.page = jsonData["page"].int ?? 0
        self.pages = jsonData["pages"].int ?? 0
        self.docs = jsonData["docs"].array?.map { return Task(jsonData: $0) } ?? []
    }
}

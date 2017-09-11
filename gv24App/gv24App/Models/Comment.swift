//
//  Comment.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/30/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import SwiftyJSON

class Comment: Entity {
    var commentId : String?
    var createAt: Date?
    var evaluationPoint : Int?
    var content: String?
    var task: Task?
    var fromUser: User?
    
    override init() {
        super.init()
    }
    
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        commentId = jsonData["_id"].string
        createAt = Date(isoDateString: jsonData["createAt"].string!)
        evaluationPoint = jsonData["evaluation_point"].int
        content = jsonData["content"].string
        task = Task(jsonData: jsonData["task"])
        fromUser = User(jsonData: jsonData["fromId"])
    }
}

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
    var userComment: User?
    
    override init() {
        super .init()
    }
    
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        commentId = jsonData["_id"].string
        let createAtString = jsonData["createAt"].string
        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = ""
        let date = dateFormatter.date(from: createAtString!)
        createAt = date
    }
}

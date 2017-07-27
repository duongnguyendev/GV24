//
//  WorkType.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import SwiftyJSON

class WorkType: Entity {
    
    var id : String?
    var name : String?
    var workDescription : String?
    var title : String?
    var image : String?
    var weight : Int?
    var price : NSNumber?
    var tools : Bool? = false
    var suggests : [Suggest] = [Suggest]()
    
    override init() {
        super.init()
    }
    override init(jsonData: JSON) {
        super.init()
        self.id = jsonData["_id"].string
        self.name = jsonData["name"].string
        self.workDescription = jsonData["description"].string
        self.title = jsonData["title"].string
        self.price = jsonData["price"].number
        self.weight = jsonData["weight"].int
        self.image = jsonData["image"].string
        self.tools = jsonData["tools"].bool
        let suggetsJson = jsonData["suggest"].arrayValue
        
        for suggestData in suggetsJson {
            self.suggests.append(Suggest(jsonData: suggestData))
        }
    }
}

class Suggest : Entity{
    var id : String?
    var name : String?
    
    override init() {
        super.init()
    }
    
    override init(jsonData: JSON) {
        super.init()
        self.id = jsonData["_id"].string
        self.name = jsonData["name"].string
    }
}

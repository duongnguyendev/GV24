//
//  WorkInfo.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/22/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import SwiftyJSON

class WorkInfo: Entity {
    var price : NSNumber?
    var evaluationPoint : NSNumber?
    var ability: [Ability]?
    override init(jsonData: JSON) {
        super.init()
        self.price = jsonData["price"].number
        self.evaluationPoint = jsonData["evaluation_point"].number
        self.ability = jsonData["ability"].array?.map { return Ability(jsonData: $0) }
    }
    
}
class Ability: Entity {
    var id: String?
    var image: String?
    var name: String?
    
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.id = jsonData["_id"].string ?? ""
        self.image = jsonData["image"].string ?? ""
        self.name = jsonData["name"].string ?? ""
    }
}

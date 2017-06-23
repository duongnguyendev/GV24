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
    var image: String?
    
    override init() {
        super.init()
    }
    override init(jsonData: JSON) {
        super.init()
        self.id = jsonData["_id"].string
        self.name = jsonData["name"].string
        self.image = jsonData["image"].string
    }
}

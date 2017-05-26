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
    
    override init(jsonData: JSON) {
        super.init()
        self.price = jsonData["price"].number
        self.evaluationPoint = jsonData["evaluation_point"].number
    }
}

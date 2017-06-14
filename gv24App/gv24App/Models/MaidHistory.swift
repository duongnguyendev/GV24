//
//  MaidHistory.swift
//  gv24App
//
//  Created by Macbook Solution on 6/9/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import SwiftyJSON
class MaidHistory: MaidProfile {
    
    override init() {
        super.init()
    }
    var times: [String]?

    override init(jsonData: JSON) {
        super.init(jsonData: jsonData["_id"])
        self.times = jsonData["times"].array?.map{ return String( describing: $0 ) } ?? []
    }
}

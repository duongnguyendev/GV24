//
//  Face.swift
//  gv24App
//
//  Created by Doyle Illusion on 9/15/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import SwiftyJSON

class Face: Entity {
    var isIdentical: Bool?
    var confidence : Double?
    
    override init(){
        super.init()
    }
    
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        
        self.isIdentical = jsonData["isIdentical"].bool
        self.confidence = jsonData["confidence"].double
    }
}

//
//  Address.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/22/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreLocation

class Address: Entity {
    
    var name : String?
    var location : CLLocationCoordinate2D?
    
    override init() {
        super.init()
    }
    init(name : String, location : CLLocationCoordinate2D){
        super.init()
        self.name = name
        self.location = location
    }
    
    override init(jsonData : JSON){
        super.init(jsonData: jsonData)
        self.name = jsonData["name"].string
        self.location = CLLocationCoordinate2D()
        self.location?.latitude = jsonData["coordinates"]["lat"].double!
        self.location?.longitude = jsonData["coordinates"]["lng"].double!
    }
}

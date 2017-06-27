//
//  Wallet.swift
//  gv24App
//
//  Created by dinhphong on 6/26/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class Wallet: Entity{
    var id: String?
    var wallet: NSNumber?
    
    override init() {
        super.init()
    }
    
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.id = jsonData["_id"].string ?? ""
        self.wallet = jsonData["wallet"].number ?? 0
    }
}

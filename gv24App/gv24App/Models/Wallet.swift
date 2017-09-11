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
    var wallet: Int?
    
    override init() {
        super.init()
        self.id = ""
        self.wallet = 0
    }
    
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        self.id = jsonData["_id"].string ?? ""
        self.wallet = jsonData["wallet"].int ?? 0
    }
}

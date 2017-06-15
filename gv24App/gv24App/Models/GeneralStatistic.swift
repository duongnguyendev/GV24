//
//  GeneralStatistic.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/12/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import SwiftyJSON

class GeneralStatistic: Entity {

    var totalPrice : Double = 0
    var wallet : Double = 0
    var numberPosted : Int = 0
    var numberRuning : Int = 0
    var numberDone : Int = 0
    var tasks : [StatisticTask]?
    
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        totalPrice = jsonData["totalPrice"].double!
        wallet = jsonData["wallet"].double!
        if let tasksData = jsonData["task"].array{
            tasks = [StatisticTask]()
            for taskData in tasksData{
                let task = StatisticTask(jsonData: taskData)
                tasks?.append(task)
                switch task.id {
                case "000000000000000000000001":
                    numberPosted = numberPosted + task.numberTask
                    break
                case "000000000000000000000002":
                    numberPosted = numberPosted + task.numberTask
                    break
                case "000000000000000000000003":
                    numberRuning = numberRuning + task.numberTask
                    break
                case "000000000000000000000004":
                    numberRuning = numberRuning + task.numberTask
                    break
                case "000000000000000000000005":
                    numberDone = numberDone + task.numberTask
                    break
                case "000000000000000000000006":
                    numberPosted = numberPosted + task.numberTask
                    break
                default:
                    break
                }
            }
        }
    }
}
class StatisticTask : Entity{
    var id : String = ""
    var numberTask : Int = 0
    
    override init(jsonData: JSON) {
        super.init(jsonData: jsonData)
        id = jsonData["_id"].string!
        numberTask = jsonData["count"].int!
    }
}

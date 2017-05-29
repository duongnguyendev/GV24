//
//  TaskManageService.swift
//  gv24App
//
//  Created by Macbook Solution on 5/29/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import SwiftyJSON
class TaskManageService: APIService{
    
    static let shared = TaskManageService()
    
    func fetchTaskManagement(process: Int,callback: @escaping TaskManageCallback){
        let url = "owner/getAllTasks?process=000000000000000000000001"
        getWithToken(url: url) { (jsons, error) in
            if error == nil{
                let status = jsons?["status"].bool ?? false
                let message = jsons? ["message"].string ?? ""
                if (status){
                    var tasks = [Task]()
                    jsons?["data"].array?.forEach({ (json) in
                        let task = Task(jsonData: json)
                        tasks.append(task)
                    })
                    DispatchQueue.main.async {
                        return callback(tasks,status,message)
                    }
                }
            }
        }
    }
}

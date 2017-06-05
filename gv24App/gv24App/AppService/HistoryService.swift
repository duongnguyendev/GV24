//
//  HistoryService.swift
//  gv24App
//
//  Created by Macbook Solution on 6/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import SwiftyJSON
class HistoryService: APIService{
    static let shared = HistoryService()
    
    func fetchHistory(type: String,completion:@escaping (TaskCompletion)){
        let url = "owner/\(type)"
        getWithToken(url: url) { (json, error) in
            if error == nil{
                var tasks = [Task]()
                json?.array?.forEach({ (json) in
                    let task = Task(jsonData: json)
                    tasks.append(task)
                })
                completion(tasks)
            }else{
                completion(nil)
            }
        }

        
    }
    
}

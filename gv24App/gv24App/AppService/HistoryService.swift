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
    
    func fetchTaskHistory(completion:@escaping (TaskHistoryCompletion)){
        let url = "owner/getHistoryTasks"
        getWithToken(url: url) { (json, error) in
            if error == nil{
                let taskHistory = TaskHistory(jsonData: json!)
                completion(taskHistory)
            }else{
                completion(nil)
            }
        }
    }
    
    func fetchUnpaidWork(completion:@escaping (UnpaidWorkCompletion)){
        let url = "owner/getDebt"
        getWithToken(url: url) { (json, error) in
            if error == nil{
                var works = [WorkUnpaid]()
                json?.array?.forEach({ (mJson) in
                    let work = WorkUnpaid(jsonData: mJson)
                    works.append(work)
                })
                completion(works)
            }else{
                completion(nil)
            }
        }

    }
    
}

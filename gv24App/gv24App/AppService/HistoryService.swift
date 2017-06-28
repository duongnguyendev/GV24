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
    func fetchMaidHistory(completion:@escaping (MaidHistoryCompletion)){
        let url = "owner/getAllWorkedMaid"
        getWithToken(url: url) { (json, error) in
            if error == nil{
                var maids = [MaidHistory]()
                json?.array?.forEach({ (json) in
                    let maid = MaidHistory(jsonData: json)
                    maids.append(maid)
                })
                completion(maids)
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
    
    func fetchListTasks(id: String,completion:@escaping (MaidTaskCompletion)){
        let url = "owner/getTaskOfMaid?maid=\(id)"
        getWithToken(url: url) { (json, error) in
            if error == nil{
                let maidTask = MaidTask(jsonData: json!)
                completion(maidTask)
            }else{
                completion(nil)
            }
        }
    }
    
    func getCommentOwner(taskID: String,completion:@escaping ((Comment?)->())){
        let url = "task/getComment?task=\(taskID)"
        getWithToken(url: url) { (json, error) in
            if error == nil{
                let comment = Comment(jsonData: json!)
                completion(comment)
            }else{
                completion(nil)
            }
        }
    }
    
    func assesmentMaid(task: String,told: String,content: String,evaluation_point: Double,completion:@escaping ((String?)->())){
        let url = "owner/comment"
        let parameters = [
            "task" : task,
            "told" : told,
            "content" : content,
            "evaluation_point" : evaluation_point
        ] as [String : Any]
        postWithTokenUrl(url: url, parameters: parameters) { (json, error) in
            if error == nil{
                completion(nil)
            }else{
                completion(error)
            }
        }
    }
    
    
}

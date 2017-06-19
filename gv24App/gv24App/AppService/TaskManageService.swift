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
    func fetchTask(process: String,completion:@escaping (TaskCompletion)){
        let url = "owner/getAllTasks?process=\(process)"
        getWithToken(url: url) { (jsons, message) in
            if message == nil{
                var tasks = [Task]()
                jsons?.array?.forEach({ (json) in
                    let task = Task(jsonData: json)
                    tasks.append(task)
                })
                completion(tasks)
            }else{
                completion(nil)
            }
        }
    }
    func deleteTask(task: Task,completion: @escaping (DeleteTaskCompletion)){
        let url = "task/delete?id=\((task.id)!)"
        let params : Dictionary<String,String> = ["id": "593f93d87a7116000498565f"]
        deleteWithToken(url: url, parameters: params) { (json, message) in
            if json == nil{
                completion(false)
            }else{
                completion(true)
            }
        }
    }
    func fetchApplicants(id: String,completion:@escaping (ApplicantCompletion)){
        let url = "task/getRequest?id=\(id)"
        getWithToken(url: url) { (json, error) in
            if error == nil{
                var applicants = [Applicant]()
                json?.array?.forEach({ (json) in
                    let applicant = Applicant(jsonData: json)
                    applicants.append(applicant)
                })
                completion(applicants, nil)
            }else{
                completion(nil, error)
            }
        }
    }
    
}

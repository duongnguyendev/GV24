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
    
    func fetchTaskNew(completion:@escaping (TaskNewCompletion)){
        let url = "owner/getAllTasks?process=000000000000000000000001"
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
    func fetchTaskAssiged(process: String,completion:@escaping (TaskAssignedCompletion)){
        let url = "owner/getAllTasks?process=\(process)"
        getWithToken(url: url) { (jsons, error) in
            if error == nil{
                var tasksAssigned = [TaskAssigned]()
                jsons?.array?.forEach({ (json) in
                    let assigned = TaskAssigned(jsonData: json)
                    tasksAssigned.append(assigned)
                })
                completion(tasksAssigned)
            }else{
                completion(nil)
            }
        }
        
    }
    
   /* func deleteTask(task: Task,completion:@escaping (TaskCompletion)){
        _ = "task/delete?id=\((task.id)!)?ownerId=\((task.stakeholder?.owner)!)"
    }*/
    
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

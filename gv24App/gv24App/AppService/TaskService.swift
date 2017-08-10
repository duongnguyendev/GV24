//
//  TaskService.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/5/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class TaskService: APIService {
    static let shared = TaskService()
    
    func postTask(params : Parameters, completion:@escaping ((String?)->())){
        let url = "task/create"
        postWidthToken(url: url, parameters: params) { (response, error) in
            if error == nil{
                completion(nil)
            }else{
                completion(error)
            }
        }
    }
    func updateTask(params : Parameters, completion:@escaping ((String?)->())){
        let url = "task/update"
        putWithToken(url: url, parameters: params) { (jsons, error) in
            if error == nil{
                completion(nil)
            }else{
                completion(error)
            }
        }
    }
    func deleteTask(task: Task,completion: @escaping (DeleteTaskCompletion)){
        let url = "task/delete"
        let params : Dictionary<String,String> = ["id": task.id!]
        deleteWithToken(url: url, parameters: params) { (json, message) in
            if json == nil{
                completion(false)
            }else{
                completion(true)
            }
        }
    }
    func sendRequestToMaid(params : Parameters, completion:@escaping ((String?)->())){
        let url = "task/sendRequest"
        postWidthToken(url: url, parameters: params) { (response, error) in
            if error == nil{
                completion(nil)
            }else{
                completion(error)
            }
        }
    }
    func getWorkTypes(completion: @escaping (([WorkType]?, String?)-> ())){
        let url = "work/getAll"
        get(url: url) { (response, error) in
            if error == nil {
                completion(self.getWorkTypesFrom(jsonData: response!), nil)
            }else{
                completion(nil, error)
            }
        }
    }
    func generalStatistic(startDate: Date?, endDate: Date?, completion: @escaping ((GeneralStatistic?, String?)->())){
        let url = "owner/statistical"
        var params = Parameters()
        if startDate != nil{
            params["startAt"] = startDate?.isoString
        }
        if endDate != nil {
            params["endAt"] = endDate?.isoString
        }
        getWithToken(url: url, params: params) { (jsonData, error) in
            if error != nil{
                completion(nil, error)
            }else{
                completion(GeneralStatistic(jsonData: jsonData!), error)
            }
        }
    }
    func getWorkTypesFrom(jsonData : JSON) -> [WorkType]?{
        if let jsonArray = jsonData.array{
            var works : [WorkType] = [WorkType]()
            for workData in jsonArray{
                works.append(WorkType(jsonData: workData))
            }
            return works.reversed()
        }
        return nil
    }
    func selectedMaid(id: String,maidId: String,completion:@escaping ((Bool?)->())){
        let url = "task/submit"
        let parameters = [
            "id": id,
            "maidId": maidId]
        postWidthToken(url: url, parameters: parameters) { (json, error) in
            if error == nil{
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    func checkInMaid(task: Task,img_checkin: UIImage,completion:@escaping ((Bool?)->())){
        let url = "task/checkin"
        var params = Dictionary<String, String>()
        params["ownerId"] = task.stakeholder?.owner
        params["id"] = task.id
        postMultipartWithToken(url: url, image: img_checkin, name: "image", parameters: params) { (json, error) in
            if error == nil{
                completion(true)
            }else{
                completion(false)
            }
        }
    }
    func checkOutMaid(id: String,completion: @escaping ((WorkUnpaid?)->())){
        let url = "task/checkout"
        let  params = ["id": id]
        postWithTokenUrl(url: url, parameters: params) { (json, error) in
            if error == nil{
                let workSuccess = WorkUnpaid(jsonData: json!)
                completion(workSuccess)
            }else{
                completion(nil)
            }
        }
    }
}

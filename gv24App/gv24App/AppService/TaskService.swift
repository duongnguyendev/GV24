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
        getWithToken(url: url) { (response, error) in
            if error == nil {
                completion(self.getWorkTypesFrom(jsonData: response!), nil)
            }else{
                completion(nil, error)
            }
        }
    }
    func generalStatistic(startDate: Date?, endDate: Date?, completion: @escaping ((GeneralStatistic?, String?)->())){
        var url = "owner/statistical"
        
        if startDate != nil && endDate != nil{
            url = url + "?startAt=\(startDate!.yearMonthDate)&endAt=\(endDate!.yearMonthDate)"
        }else{
            if startDate != nil {
                url = url + "?startAt=\(startDate!.yearMonthDate)"
            }
            if endDate != nil{
                url = url + "?endAt=\(endDate!.yearMonthDate)"
            }
        }
        getWithToken(url: url) { (jsonData, error) in
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
            return works
        }
        return nil
    }
}

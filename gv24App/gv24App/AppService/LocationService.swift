//
//  LocationService.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 6/27/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire

class LocationService: NSObject {
    
    
    static func locationFor(address: String, completion : @escaping ((_ cordinate: CLLocationCoordinate2D?, _ error : String?)->())){
        let url = "https://maps.googleapis.com/maps/api/geocode/json"
        let parameters = ["address": address]
        Alamofire.request(url, parameters: parameters).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let status = json["status"].string
                if status != "OK"{
                    completion(nil,"AddressError")
                }else{
                    let results = json["results"].array
                    let geometry = results?[0]["geometry"]
                    let location = geometry?["location"]
                    let lat = location?["lat"].double
                    let lng = location?["lng"].double
                    let coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
                    completion(coordinate, nil)
                }
            case .failure(let error):
                completion(nil, error.localizedDescription)
                print(error)
            }
        }
    }
}

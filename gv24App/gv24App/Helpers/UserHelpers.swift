//
//  UserHelpers.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 5/22/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase
import FirebaseAuth

let CURRENT_USER : String = "currentUser"
let TOKEN : String = "token"

class UserHelpers: NSObject {
    
    static var isLogin : Bool {
        if UserDefaults.standard.value(forKey: TOKEN) != nil{
            return true
        }
        return false
    }
    
    static var token : String? {
        return UserDefaults.standard.value(forKey: TOKEN) as? String
    }
    
    static var notificationIsAvailble : Bool{
        if let isAvailble = UserDefaults.standard.value(forKey: "notificationIsAvailble") as? Bool{
            return isAvailble
        }
        return true
    }
    
    static var currentUser : User? {
        if isLogin {
            let userDic = UserDefaults.standard.value(forKey: CURRENT_USER) as! Dictionary<String, Any>
            let user = User()
            user.userId = userDic["userId"] as? String
            user.userName = userDic["userName"] as? String
            user.name = userDic["name"] as? String
            user.email = userDic["email"] as? String
            user.phone = userDic["phone"] as? String
            user.avatarUrl = userDic["avatarUrl"] as? String
            let address = Address()
            address.name = userDic["addressName"] as? String
            let lat = userDic["lat"] as? Double
            let lng = userDic["lng"] as? Double
            let location = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
            address.location = location
            user.address = address
            user.gender = userDic["gender"] as? Int
            return user
        }
        
        return nil
    }
    
    static func save(user : User, newToken: String?) {
        let dic = ["userId":user.userId!,
                   "userName":user.userName!,
                   "name":user.name!,
                   "email":user.email!,
                   "phone":user.phone!,
                   "avatarUrl": user.avatarUrl!,
                   "addressName":(user.address?.name)!,
                   "lat":(user.address?.location?.latitude)!,
                   "lng":(user.address?.location?.longitude)!,
                   "gender":user.gender!] as Dictionary<String, Any>
        
        UserDefaults.standard.set(dic, forKey: CURRENT_USER)
        
        if newToken != nil {
            UserDefaults.standard.set(newToken, forKey: TOKEN)
        }
    }
    
    static func turnNotificaitonOn(_ isOn:Bool){
        UserDefaults.standard.set(isOn, forKey: "notificationIsAvailble")
    }
    
    static func logOut() {
        self.signOutFirebase()
        UserDefaults.standard.removeObject(forKey: TOKEN)
        UserDefaults.standard.removeObject(forKey: CURRENT_USER)
    }
    
    static func signOutFirebase() {
        let firebaseAuth = FIRAuth.auth()
        do {
            try firebaseAuth?.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}

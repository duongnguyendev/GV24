//
//  NotificationHelpers.swift
//  gv24App
//
//  Created by Doyle Illusion on 9/13/17.
//  Copyright © 2017 HBBs. All rights reserved.
//

import Foundation
import Whisper

class NotificationHelpers {
    
    static let shared = NotificationHelpers()
    
    func handleNotification(userInfo: [AnyHashable : Any]) {
        guard let status = userInfo["status"] as? String else { return }
        
        guard let destinationViewController = appDelegate?.window??.rootViewController as? UINavigationController else { return }
        
        self.handleNotification(destinationViewController: destinationViewController, status: status)
    }
    
    fileprivate func handleNotification(destinationViewController: UINavigationController, status: String) {
        destinationViewController.popToRootViewController(animated: true)
        
        switch status {
        case "0":
            let taskManagementVC = TaskManagementVC()
            taskManagementVC.isFromPush = true
            taskManagementVC.scrollToIndex = 0
            destinationViewController.pushViewController(taskManagementVC, animated: true)
        case "2":
            let taskManagementVC = TaskManagementVC()
            taskManagementVC.isFromPush = true
            taskManagementVC.scrollToIndex = 1
            destinationViewController.pushViewController(taskManagementVC, animated: true)
        case "10":
            let historyVC = HistoryVC()
            historyVC.isFromPush = true
            historyVC.scrollToIndex = 0
            destinationViewController.pushViewController(historyVC, animated: true)
        case "11":
            let historyVC = HistoryVC()
            historyVC.isFromPush = true
            historyVC.scrollToIndex = 2
            destinationViewController.pushViewController(historyVC, animated: true)
        case "88":
            let taskManagementVC = TaskManagementVC()
            taskManagementVC.isFromPush = true
            taskManagementVC.scrollToIndex = 0
            destinationViewController.pushViewController(taskManagementVC, animated: true)
        default:
            break
        }
    }
}

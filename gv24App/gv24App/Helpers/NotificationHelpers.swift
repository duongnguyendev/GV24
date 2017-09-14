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
        guard let aps = userInfo["aps"] as? [String: AnyObject] else { return }
        guard let status = userInfo["status"] as? Int else { return }
        guard let alert = aps["alert"] as? [String: AnyObject] else { return }
        guard let title = alert["title"] as? String else { return }
        
        guard let destinationViewController = appDelegate?.window??.rootViewController as? UINavigationController else { return }
        
        guard isWakeFromPush == false else {
            self.handleNotification(destinationViewController: destinationViewController, status: status)
            isWakeFromPush = false
            return
        }
        
        var announcement = Announcement(title: title, subtitle: self.getTitleForStatus(status: status), image: UIImage(named: "logo"))
        announcement.action = handleAction(destinationViewController: destinationViewController, status: status)
        announcement.duration = 5
        Whisper.show(shout: announcement, to: destinationViewController, completion: nil)
    }
    
    fileprivate func getTitleForStatus(status: Int) -> String {
        switch status {
        case 0:
            return LanguageManager.shared.localized(string: "MaidRefuseAcceptedWork")!
        case 2:
            return LanguageManager.shared.localized(string: "MaidAcceptWork")!
        case 10:
            return LanguageManager.shared.localized(string: "MaidReceivedMoney")!
        case 11:
            return LanguageManager.shared.localized(string: "MaidNotReceivedMoney")!
        case 88:
            return LanguageManager.shared.localized(string: "MaidBecomeApplicant")!
        default:
            return LanguageManager.shared.localized(string: "DefaultNotification")!
        }
    }
    
    fileprivate func handleAction(destinationViewController: UINavigationController, status: Int) -> (() -> Void) {
        func route() {
            handleNotification(destinationViewController: destinationViewController, status: status)
        }
        return route
    }
    
    fileprivate func handleNotification(destinationViewController: UINavigationController, status: Int) {
        destinationViewController.popToRootViewController(animated: true)
        
        switch status {
        case 0:
            let taskManagementVC = TaskManagementVC()
            taskManagementVC.isFromPush = true
            taskManagementVC.scrollToIndex = 0
            destinationViewController.pushViewController(taskManagementVC, animated: true)
        case 2:
            let taskManagementVC = TaskManagementVC()
            taskManagementVC.isFromPush = true
            taskManagementVC.scrollToIndex = 1
            destinationViewController.pushViewController(taskManagementVC, animated: true)
        case 10:
            let historyVC = HistoryVC()
            historyVC.isFromPush = true
            historyVC.scrollToIndex = 0
            destinationViewController.pushViewController(historyVC, animated: true)
        case 11:
            let historyVC = HistoryVC()
            historyVC.isFromPush = true
            historyVC.scrollToIndex = 2
            destinationViewController.pushViewController(historyVC, animated: true)
        case 88:
            let taskManagementVC = TaskManagementVC()
            taskManagementVC.isFromPush = true
            taskManagementVC.scrollToIndex = 0
            destinationViewController.pushViewController(taskManagementVC, animated: true)
        default:
            break
        }
    }
}

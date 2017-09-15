//
//  AppDelegate.swift
//  gv24App
//
//  Created by Nguyen Duy Duong on 4/26/17.
//  Copyright © 2017 HBB. All rights reserved.
//

import UIKit
import Google
import GoogleSignIn
import GoogleMaps
import FirebaseCore
import UserNotifications
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import FacebookCore
import FacebookLogin
import Alamofire
import IQKeyboardManagerSwift

var isWakeFromPush = false

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, UNUserNotificationCenterDelegate, FIRMessagingDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Register notifications
        self.registerForPushNotifications(application: application)
        
        // Configure Firebase
        FIRApp.configure()
        
        // Configure keyboard manager
        IQKeyboardManager.sharedManager().enable = true
        
        // Configure Google Sign In
        self.configureGoogleSignIn()

        // Override point for customization after application launch.
        self.routeMeToTheTheater()
        
        // Handle notifications
        if let _ = launchOptions?[.remoteNotification] as? [String: AnyObject] {
            Thread.sleep(forTimeInterval: 3)
            isWakeFromPush = true
        }
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Raw Token: \(token)")
        
        //Messaging
        
        //let token = FIRMessaging.messaging().tpken
        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: .unknown)
        //FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.prod)
    }
    
    fileprivate func registerForPushNotifications(application: UIApplication) {
        //        if #available(iOS 10.0, *) {
        //            // For iOS 10 display notification (sent via APNS)
        //            UNUserNotificationCenter.current().delegate = self
        //            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        //            UNUserNotificationCenter.current().requestAuthorization(
        //                options: authOptions,
        //                completionHandler: {_, _ in })
        //            // For iOS 10 data message (sent via FCM
        //            FIRMessaging.messaging().remoteMessageDelegate = self
        //        } else {
        let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
        //        }
        application.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }

    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        NotificationHelpers.shared.handleNotification(userInfo: userInfo)
        
        completionHandler(.newData)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        NotificationHelpers.shared.handleNotification(userInfo: userInfo)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {   }
    func applicationDidBecomeActive(_ application: UIApplication) { AppEventsLogger.activate(application) }
    func applicationWillTerminate(_ application: UIApplication) {}
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let google = GIDSignIn.sharedInstance().handle(url,
                                                       sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                       annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        let facebook = SDKApplicationDelegate.shared.application(app, open: url, options: options)
        return google || facebook
    }
    
    fileprivate func configureGoogleSignIn() {
        GMSServices.provideAPIKey("AIzaSyAX9zDfRhJOhCVJya1bawKqGRNPJKsqk7Q")
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
    }
    
//    fileprivate func getNotificationSettings() {
//        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
//            print("Notification settings: \(settings)")
//            
//            guard settings.authorizationStatus == .authorized else { return }
//            UIApplication.shared.registerForRemoteNotifications()
//        }
//    }
    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        print(notification)
//    }
//    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        print(response)
//    }
    
    fileprivate func routeMeToTheTheater() {
        self.window = UIWindow(frame: UIScreen.main.bounds);
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: HomeVC())
    }
    
    //MARK: - Google delegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error != nil else { return }
        print("\(error.localizedDescription)")
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {}
}

class NetworkStatus {
    
    static let sharedInstance = NetworkStatus()
    
    private init() {}
    
    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")
    func startNetworkReachabilityObserver(completion:@escaping ((_ networkConnected: Bool)->())){
        reachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
                print("The network is not reachable")
                completion(false)
            case .unknown :
                print("It is unknown whether the network is reachable")
                completion(false)
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
                completion(true)
            case .reachable(.wwan):
                print("The network is reachable over the WWAN connection")
                completion(true)
            }
        }
        reachabilityManager?.startListening()
    }
}

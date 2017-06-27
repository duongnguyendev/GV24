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
import Firebase
import FirebaseMessaging
import UserNotifications
import FacebookCore
import FacebookLogin

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, UNUserNotificationCenterDelegate, FIRMessagingDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Firebase config
        FIRApp.configure()
        let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()
        FIRMessaging.messaging().remoteMessageDelegate = self
        
        //        NotificationCenter.default.addObserver(self,
        //                                               selector: #selector(self.tokenRefreshNotification),
        //                                               name: .firInstanceIDTokenRefresh,
        //                                               object: nil)
        
        GMSServices.provideAPIKey("AIzaSyAX9zDfRhJOhCVJya1bawKqGRNPJKsqk7Q")
        // Initialize sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
//        GIDSignIn.sharedInstance().delegate = self
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds);
        window?.makeKeyAndVisible()
        window?.rootViewController = LaunchScreenVC()
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.sandbox)
        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.prod)
        FIRMessaging.messaging().connect { (error) in
            
        }
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error)
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
        print("userInfo")
        print(userInfo)
        let topWindow = UIWindow(frame: UIScreen.main.bounds)
        topWindow.rootViewController = UIViewController()
        topWindow.windowLevel = UIWindowLevelAlert + 1
        
        let alert = UIAlertController(title: "notification", message: "abcd", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        topWindow.makeKeyAndVisible()
        
        topWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    //FCM delegate
    
    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
        print("userInfo")
        print(remoteMessage.appData)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // recevi remote notification here
        
        let topWindow = UIWindow(frame: UIScreen.main.bounds)
        topWindow.rootViewController = UIViewController()
        topWindow.windowLevel = UIWindowLevelAlert + 1
        
        let alert = UIAlertController(title: "notification", message: "abcd", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        topWindow.makeKeyAndVisible()
        
        topWindow.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        AppEventsLogger.activate(application)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let google = GIDSignIn.sharedInstance().handle(url,
                                                       sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                       annotation: options[UIApplicationOpenURLOptionsKey.annotation])
        let facebook = SDKApplicationDelegate.shared.application(app, open: url, options: options)
        return google || facebook
    }
    
    
    //MARK: - Google delegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            //            Perform any operations on signed in user here.
            // ...
        } else {
            print("\(error.localizedDescription)")
        }
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    
    
}

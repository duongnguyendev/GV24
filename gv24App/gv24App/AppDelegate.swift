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
        
        // Configure Firebase
        FIRApp.configure()
        
        // Register notifications
        self.registerForPushNotifications()
        
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
        print("Device Token Raw: \(deviceToken)")
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        
        //Messaging
        
        //let token = FIRMessaging.messaging().tpken
        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.sandbox)
        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.prod)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }

    func applicationReceivedRemoteMessage(_ remoteMessage: FIRMessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
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
    
    fileprivate func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("Permission granted: \(granted)")
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    fileprivate func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            
            guard settings.authorizationStatus == .authorized else { return }
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
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

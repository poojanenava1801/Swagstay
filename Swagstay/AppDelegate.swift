//
//  AppDelegate.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 28/01/23.
//

import UIKit
import SwiftyJSON
import FirebaseCore
import FirebaseInstallations
import IQKeyboardManagerSwift


@main
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        Installations.installations().authToken { result, _ in
            print("Your instance ID FCM token is \(result?.authToken ?? "n/a")")
            Preference.shared.setUserFCMToken(token: result?.authToken ?? "n/a")
        }
        registerForPushNotifications()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        if let refreshedToken = InstanceID.instanceID().token() {
//            print("InstanceID token: \(refreshedToken)")
//        }
//    }
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        // request permission from user to send notification
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        //if #available(iOS 12.0, *){
        //   options.insert(.providesAppNotificationSettings)
        //}
        UNUserNotificationCenter.current().requestAuthorization(options:options, completionHandler: { authorized, error in
            if authorized {
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.registerForRemoteNotifications()
                    UNUserNotificationCenter.current().delegate = self
                })
            }
        })
    }


}

extension AppDelegate
{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler   completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // show the notification alert (banner), and with sound
        completionHandler([.alert, .badge, .sound])
        print(notification.request.content.userInfo)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        guard ((UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController) != nil else {
            return
        }
        
        let userInfo = response.notification.request.content.userInfo
        let data = JSON(userInfo)
        
        let   appState = UIApplication.shared.applicationState
        
        if  appState == .active
        {
//            let topController = UIApplication.topViewController()
//            if data["custom"]["a"]["type"].stringValue == "like" || data["custom"]["a"]["type"].stringValue == "reply"{
//                if topController is ChatDetailVC {
//                    // Do here
//                }else{
//                    let destVC = ChatDetailVC.instantiate(storyboard: .chatDetail)
//                    destVC.postid = data["custom"]["a"]["message_id"].stringValue
//                    destVC.showTopView = true
//                    destVC.fromNoti = true
//                    UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
//                }
//            }else if data["custom"]["a"]["type"].stringValue == "follow"
//            {
//                let destVC = UserProfileVC.instantiate(storyboard: .userProfile)
//                destVC.userId = data["custom"]["a"]["kingpin_id"].stringValue//data["aps"]["kingpin_id"].stringValue
//                UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
//            }else if data["custom"]["a"]["type"].stringValue == "payment"
//            {
//                let topController =  UIApplication.topViewController()
//                if topController is PaymentVC {
//
//                }else{
//                    if !PurchasesManager.shared.isSubscribed
//                    {
//                        let destVC = PaymentVC.instantiate(storyboard: .payment)
//                        UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
//                    }
//                }
//            }else if data["custom"]["a"]["kingpin_id"].intValue > 0
//            {
//
//            }else if data["custom"]["a"]["type"].stringValue == "FreeTrialNoti"{
//
//                Preference.shared.saveFreeTrialNoti(status: "true")
//                let pageType =  RCValues.sharedInstance.string(forKey: .pageType)
//                if pageType == "1"{
//                    let destVC = PaymentVC.instantiate(storyboard: .payment)
//                    //destVC.fromNotification = true
//
//                    DispatchQueue.main.asyncAfter(deadline:.now() + 1, execute: {
//                        UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
//                    })
//
//                }else if pageType == "2"{
//                    let destVC = PaymentNewVC.instantiate(storyboard: .payment)
//                   //destVC.fromnotification = true
//
//                    DispatchQueue.main.asyncAfter(deadline:.now() + 1, execute: {
//                        UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
//                    })
//
//                }else if pageType == "3"{
//                    let destVC = PaymentNewVC.instantiate(storyboard: .payment)
//                    //destVC.fromnotification = true
//
//                    DispatchQueue.main.asyncAfter(deadline:.now() + 1, execute: {
//                        UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
//                    })
//
//                }else  if pageType == "4"{
//                    let destVC = PaymentViewLatestVC.instantiate(storyboard: .payment)
//                   // destVC.fromNotifications = true
//
//                    DispatchQueue.main.asyncAfter(deadline:.now() + 1, execute: {
//                        UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
//                    })
//
//            }else{
//                let destVC = PaymentVC.instantiate(storyboard: .payment)
//                UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
//            }
//            }
        }else if appState == .background{
        
//            let topController = UIApplication.topViewController()
//            if data["custom"]["a"]["type"].stringValue == "like" || data["custom"]["a"]["type"].stringValue == "reply"{
//                if topController is ChatDetailVC {
//                    // Do here
//                }else{
//                    let destVC = ChatDetailVC.instantiate(storyboard: .chatDetail)
//                    destVC.postid = data["custom"]["a"]["message_id"].stringValue
//                    destVC.showTopView = true
//                    destVC.fromNoti = true
//                    UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
//                }
//            }else if data["custom"]["a"]["type"].stringValue == "follow"
//            {
//                let destVC = UserProfileVC.instantiate(storyboard: .userProfile)
//                destVC.userId = data["custom"]["a"]["kingpin_id"].stringValue//data["aps"]["kingpin_id"].stringValue
//                UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
//            }else if data["custom"]["a"]["type"].stringValue == "payment"
//            {
//                let topController =  UIApplication.topViewController()
//                if topController is PaymentVC {
//
//                }else{
//                    if !PurchasesManager.shared.isSubscribed
//                    {
//                        let destVC = PaymentVC.instantiate(storyboard: .payment)
//                        UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
//                    }
//                }
//            }else if data["custom"]["a"]["kingpin_id"].intValue > 0
//            {
//
//            }else if data["custom"]["a"]["type"].stringValue == "FreeTrialNoti"{
//                Preference.shared.saveFreeTrialNoti(status: "true")
//
////                let pageType =  RCValues.sharedInstance.string(forKey: .pageType)
////                if pageType == "1"{
////                    let destVC = PaymentVC.instantiate(storyboard: .payment)
////                    //destVC.fromNotification = true
////
////                    DispatchQueue.main.asyncAfter(deadline:.now() + 1, execute: {
////                        UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
////                    })
////
////                }else if pageType == "2"{
////                    let destVC = PaymentNewVC.instantiate(storyboard: .payment)
////                    //destVC.fromnotification = true
////
////                    DispatchQueue.main.asyncAfter(deadline:.now() + 1, execute: {
////                        UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
////                    })
////
////                }else if pageType == "3"{
////                    let destVC = PaymentNewVC.instantiate(storyboard: .payment)
////                   // destVC.fromnotification = true
////
////                    DispatchQueue.main.asyncAfter(deadline:.now() + 1, execute: {
////                        UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
////                    })
////
////                }else  if pageType == "4"{
////                    let destVC = PaymentViewLatestVC.instantiate(storyboard: .payment)
////                   // destVC.fromNotifications = true
////
////                    DispatchQueue.main.asyncAfter(deadline:.now() + 1, execute: {
////                        UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
////                    })
////
////            }else{
////                let destVC = PaymentVC.instantiate(storyboard: .payment)
////                UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
////            }
//           }

        }else if appState == .inactive
        {
//            if data["custom"]["a"]["type"].stringValue == "like" || data["custom"]["a"]["type"].stringValue == "reply"{
//                let vc = ChatDetailVC.instantiate(storyboard: .chatDetail)
//                vc.postid = data["custom"]["a"]["message_id"].stringValue
//                vc.showTopView = true
//                vc.fromNoti = true
//                UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
//            }else if data["custom"]["a"]["type"].stringValue == "follow"
//            {
//                let destVC = UserProfileVC.instantiate(storyboard: .userProfile)
//                destVC.userId = data["aps"]["kingpin_id"].stringValue
//                UIApplication.topViewController()?.present(destVC, animated: true, completion: nil)
//
//            }else if data["custom"]["a"]["type"].stringValue == "payment"
//            {
//                print("nothig to do..")
//            }else if data["custom"]["a"]["kingpin_id"].intValue > 0
//            {
//                let destVC = UserProfileVC.instantiate(storyboard: .userProfile)
//                destVC.userId =  data["custom"]["a"]["kingpin_id"].stringValue
//                UIApplication.topViewController()?.present(destVC, animated: true, completion: nil)
//            }else if data["custom"]["a"]["type"].stringValue == "FreeTrialNoti"{
//                Preference.shared.saveFreeTrialNoti(status: "true")
//
////                let pageType =  RCValues.sharedInstance.string(forKey: .pageType)
////                if pageType == "1"{
////                    let destVC = PaymentVC.instantiate(storyboard: .payment)
////                    destVC.fromNotification = true
////
////                    DispatchQueue.main.asyncAfter(deadline:.now() + 1, execute: {
////                        UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
////                    })
////
////                }else if pageType == "2"{
////                    let destVC = PaymentNewVC.instantiate(storyboard: .payment)
////                    destVC.fromnotification = true
////                    DispatchQueue.main.asyncAfter(deadline:.now() + 1, execute: {
////                        UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
////                    })
////
////                }else if pageType == "3"{
////                    let destVC = PaymentNewVC.instantiate(storyboard: .payment)
////                    destVC.fromnotification = true
////                    DispatchQueue.main.asyncAfter(deadline:.now() + 1, execute: {
////                        UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
////                    })
////
////                }else  if pageType == "4"{
////                    let destVC = PaymentViewLatestVC.instantiate(storyboard: .payment)
////                    destVC.fromNotifications = true
////                    DispatchQueue.main.asyncAfter(deadline:.now() + 1, execute: {
////                        UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
////                    })
////
////            }else{
////
////                let destVC = PaymentVC.instantiate(storyboard: .payment)
////                DispatchQueue.main.asyncAfter(deadline:.now() + 1, execute: {
////                    UIApplication.topViewController()?.navigationController?.pushViewController(destVC, animated: true)
////                })
////
////            }
//            }
        }
        completionHandler()
    }
}





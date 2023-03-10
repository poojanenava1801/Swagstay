

import Foundation
import StoreKit
let Defaults = UserDefaults.standard

struct StoreReviewHelper {

    static func incrementAppOpenedCount() { // called from appdelegate didfinishLaunchingWithOptions:

        
        guard var appOpenCount = Defaults.value(forKey: UserDefaultsKeys.APP_OPENED_COUNT) as? Int else {
            Defaults.set(1, forKey: UserDefaultsKeys.APP_OPENED_COUNT)
            Defaults.synchronize()
            return
        }
        appOpenCount += 1
        Defaults.set(appOpenCount, forKey: UserDefaultsKeys.APP_OPENED_COUNT)
        Defaults.synchronize()
        
        
    }
    
    static func incrementABAppOpenedCount() {
        guard var appOpenCountAb = Defaults.value(forKey: UserDefaultsKeys.APP_OPENED_COUNT_AB) as? Int else {
            Defaults.set(1, forKey: UserDefaultsKeys.APP_OPENED_COUNT_AB)
            Defaults.synchronize()
            return
        }
        appOpenCountAb += 1
        Defaults.set(appOpenCountAb, forKey: UserDefaultsKeys.APP_OPENED_COUNT_AB)
        Defaults.synchronize()
    }
    
    
    static func checkAndAskForReview() { // call this whenever appropriate
        // this will not be shown everytime. Apple has some internal logic on how to show this.
        guard let appOpenCount = Defaults.value(forKey: UserDefaultsKeys.APP_OPENED_COUNT) as? Int else {
            Defaults.set(1, forKey: UserDefaultsKeys.APP_OPENED_COUNT)
            return
        }
        
        switch appOpenCount {
        case 10,50,100:
            StoreReviewHelper().requestReview()
        case _ where appOpenCount%100 == 0 :
            StoreReviewHelper().requestReview()
        default:
            print("App run count is : \(appOpenCount)")
            break;
        }
    }
    
    fileprivate func requestReview() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        }
        
        if #available(iOS 14.0, *) {
            
            let windowScene = UIApplication.shared
                .connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first
            if let windowScene = windowScene as? UIWindowScene {
                SKStoreReviewController.requestReview(in: windowScene)
            }
        }
    }
    
    
//    static func incrementShowPageCount() { // called from appdelegate didfinishLaunchingWithOptions:
//        guard var appOpenCount = Defaults.value(forKey: UserDefaultsKeys.SHOW_PAYMENT_PAGE_COUNT) as? Int else {
//            Defaults.set(1, forKey: UserDefaultsKeys.SHOW_PAYMENT_PAGE_COUNT)
//            return
//        }
//        appOpenCount += 1
//        Defaults.set(appOpenCount, forKey: UserDefaultsKeys.SHOW_PAYMENT_PAGE_COUNT)
//    }
    
    
}


struct UserDefaultsKeys {
    static let APP_OPENED_COUNT = "APP_OPENED_COUNT"
    static let APP_OPENED_COUNT_AB = "APP_OPENED_COUNT_AB"
}


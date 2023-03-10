
import Foundation
import Reachability
import NotificationBannerSwift
import UIKit
class NetworkManager {
    static let shared = NetworkManager()
    
    var isNetworkConnected = true
    let reachability = try! Reachability()
    var banner = NotificationBanner(title: "Network Unavailable.", subtitle:"", style: .danger)
    
    
    func setup()
    {
        reachability.whenReachable = { reachability in
            self.isNetworkConnected = true
            self.hidebannder()
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
            self.isNetworkConnected = false
            print("Network not available")
            self.showBanner()
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        banner.bannerHeight = 55
        banner.titleLabel?.textAlignment = .center
        banner.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 14.0)
        banner.autoDismiss = false
        banner.haptic = .heavy
    }
    deinit {
        self.reachability.stopNotifier()
    }
    
    
    func showBanner()
    {
        
        let bannerQueueToDisplaySeveralBanners = NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1)
        banner.show(queue: bannerQueueToDisplaySeveralBanners)
    }
    
    func hidebannder()
    {
        banner.dismiss()
    }
    
}


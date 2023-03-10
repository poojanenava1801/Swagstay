

import Foundation
import UIKit
import MBProgressHUD
import NotificationBannerSwift

//let window:UIWindow = UIApplication.shared.windows.last!
let window:UIWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.last ?? UIWindow()

let appDelegate = UIApplication.shared.delegate as! AppDelegate

//Show alert toast
func showAlertError(message: String) {
    
    let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alert.addAction(OKAction)
    alert.view.tintColor = UIColor.init(hexString: "C9352D")
    // loadingNotification.label.textColor = UIColor.orange
    window.rootViewController?.present(alert, animated: true, completion: nil)
}

//MARK: - Show/Hide HudView(loader)
func showHudWithTitle(title:String?){
    let loadingNotification = MBProgressHUD.showAdded(to: window, animated: true)
    loadingNotification.mode = MBProgressHUDMode.indeterminate
    loadingNotification.label.text =  title!
    //loadingNotification.label.textColor = UIColor.orange
    loadingNotification.alpha = 1.0
}

func showHud(){
    let hud = MBProgressHUD.showAdded(to: window, animated: true)
    hud.mode = MBProgressHUDMode.indeterminate
    hud.label.text =  "Please wait..."
    hud.contentColor = ColorNamed.kpDarkBlue
    hud.isUserInteractionEnabled = false
    hud.alpha = 1.0
    
    
    window.visibleViewController?.view.isUserInteractionEnabled = false
    //window.visibleViewController?.currentTabBar?.view.isUserInteractionEnabled = false
    
    //    self.view.isUserInteractionEnabled = false
    //    self.currentTabBar?.view.isUserInteractionEnabled = false
    
}



func showHudNew(vc:UIViewController){
    //let hud = MBProgressHUD.showAdded(to: window, animated: true)
    let hud = MBProgressHUD.showAdded(to: vc.view, animated: true)
    hud.mode = MBProgressHUDMode.indeterminate
    hud.label.text =  "Please wait..."
    hud.contentColor = ColorNamed.kpDarkBlue
    hud.isUserInteractionEnabled = false
    hud.alpha = 1.0
}

func hideHud(){
    DispatchQueue.main.async {
        MBProgressHUD.hide(for:window, animated: true)
        window.visibleViewController?.view.isUserInteractionEnabled = true
        //window.visibleViewController?.currentTabBar?.view.isUserInteractionEnabled = true
    }
}

func showBanner(message:String,duration:Double = 0.5)
{
    let banner = NotificationBanner(title: message, subtitle:"", style: .info)
    banner.bannerHeight = 60
    banner.titleLabel?.textAlignment = .center
    banner.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 16.0)
    banner.duration = duration
    
    DispatchQueue.main.async {
        let bannerQueueToDisplaySeveralBanners = NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1)
        banner.show(queue: bannerQueueToDisplaySeveralBanners)
    }
}

func showBannerPayoutPage(message:String)
{
    let banner = NotificationBanner(title: message, subtitle:"", style: .info)
    banner.bannerHeight = 150
    banner.titleLabel?.textAlignment = .center
    banner.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 16.0)
    banner.duration = 8
    let bannerQueueToDisplaySeveralBanners = NotificationBannerQueue(maxBannersOnScreenSimultaneously: 1)
    banner.show(queue: bannerQueueToDisplaySeveralBanners)
}



//extension UIApplication {
//    class func topViewController(base: UIViewController? = window.rootViewController) -> UIViewController? {
//        if let nav = base as? UINavigationController {
//            return topViewController(base: nav.visibleViewController)
//        }
//        if let tab = base as? UITabBarController {
//            if let selected = tab.selectedViewController {
//                return topViewController(base: selected)
//            }
//        }
//        if let presented = base?.presentedViewController {
//            return topViewController(base: presented)
//        }
//        return base
//    }
//}

extension UIWindow {
    
    var visibleViewController: UIViewController? {
        guard let rootViewController = rootViewController else {
            return nil
        }
        return visibleViewController(for: rootViewController)
    }
    
    private func visibleViewController(for controller: UIViewController) -> UIViewController {
        var nextOnStackViewController: UIViewController? = nil
        if let presented = controller.presentedViewController {
            nextOnStackViewController = presented
        } else if let navigationController = controller as? UINavigationController,
                  let visible = navigationController.visibleViewController {
            nextOnStackViewController = visible
        } else if let tabBarController = controller as? UITabBarController,
                  let visible = (tabBarController.selectedViewController ??
                                 tabBarController.presentedViewController) {
            nextOnStackViewController = visible
        }
        
        if let nextOnStackViewController = nextOnStackViewController {
            return visibleViewController(for: nextOnStackViewController)
        } else {
            return controller
        }
    }
    
}

extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}



import UIKit

extension UIStoryboard {
    //  If there are multiple storyboards in the project, each one must be named here:
    enum Storyboard: String {
        case main  = "Main"
//        case home = "Home"
//        case sideMenu = "SideMenu"
        case login  = "Login"
        case notification = "Notification"
        case payment = "Payment"
        case helpPopup = "HelpPopUp"
        case gameDetail = "GameDetail"
        case chatDetail = "ChatDetail"
        case Cart = "Cart"
        case userProfile = "User"
        case MyProfile = "MyProfile"
        case sideMenu = "SideMenu"
        case rules = "Rules"
        case Mykingpin = "MyKingpin"
        case requestPayout = "RequestPayout"
        case paymentHistory = "PaymentHistory"
     }
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.rawValue, bundle: bundle)
    }
    
//    class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
//        return UIStoryboard(name: storyboard.rawValue, bundle: bundle)
//    }
//    
//    func instantiateViewController<T: UIViewController>() -> T {
//        guard let viewController = instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
//            fatalError("Could not find view controller with name \(T.storyboardIdentifier)")
//        }
//        
//        return viewController
//    }
}

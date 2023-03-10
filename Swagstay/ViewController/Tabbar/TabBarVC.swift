//
//  TabBarVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 29/01/23.
//

import UIKit

class TabBarVC: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(AppTabBar(frame: tabBar.frame), forKey: "tabBar")

        //Assign self for delegate for that ViewController can respond to UITabBarControllerDelegate methods
        view.backgroundColor = .systemBackground
           UITabBar.appearance().barTintColor = .systemBackground
           tabBar.tintColor = .label
//        tabBar.layer.borderWidth = 0.50
//        tabBar.layer.borderColor = UIColor.gray.cgColor
        
        self.delegate = self
        setupVCs()
        setupCenterButton()
        UITabBar.appearance().unselectedItemTintColor = .lightGray
        UITabBar.appearance().tintColor = UIColor(hexString: "479D9A")
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create Tab one
//        let tabOne = Welcome1VC()
//        let tabOneBarItem = UITabBarItem(title: "Tab 1", image: UIImage(named: "defaultImage.png"), selectedImage: UIImage(named: "selectedImage.png"))
//
//        tabOne.tabBarItem = tabOneBarItem
//
//
//        // Create Tab two
//        let tabTwo = GetOTPVC()
//        let tabTwoBarItem2 = UITabBarItem(title: "Tab 2", image: UIImage(named: "defaultImage2.png"), selectedImage: UIImage(named: "selectedImage2.png"))
//
//        tabTwo.tabBarItem = tabTwoBarItem2
//
//
//        self.viewControllers = [tabOne, tabTwo]
    }
    
    func setupCenterButton() {
    //   tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 25)], for: .normal)

        let modelName = UIDevice.modelName
        let modelArray = modelName.split(separator: " ").last
        let modelArrayInt = String(modelArray ?? "")
      
        //tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.setCustomFont(name: .bold, size: .x13)], for: .normal)

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        
        var centerButtonFrame = view.frame
        centerButtonFrame.origin.x = tabBar.bounds.width / 2 - centerButtonFrame.size.width/2
        view.backgroundColor = UIColor.white

        print("Arrayy::", modelArrayInt)
        if modelArrayInt == "Pro" || modelArrayInt == "Max" || modelArrayInt == "11" || modelArrayInt == "12" || modelArrayInt == "13" || modelArrayInt == "mini" || modelArrayInt == "XR" {
            centerButtonFrame.origin.y = tabBar.bounds.height - centerButtonFrame.height - 65
        } else {
            centerButtonFrame.origin.y = tabBar.bounds.height - centerButtonFrame.height - 20//45
        }
        

        view.frame = centerButtonFrame

        view.layer.cornerRadius = view.frame.width / 2
//        view.layer.borderColor = UIColor.gray.cgColor
//        view.layer.borderWidth = 0.5
        
        view.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 2.0, opacity: 0.5)

        
        let image = UIImageView()
        
        view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 30).isActive = true
        image.heightAnchor.constraint(equalToConstant: 30).isActive = true
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.image = UIImage(named: "ic_baseline_offer_24")
        image.tintColor = .gray
        [image, view].forEach { vw in
            vw.addTap {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue:"sidemenu"), object: nil, userInfo: ["index":2])
                image.tintColor = UIColor(hexString: "479D9A")
//                let VC = HomeRouter.createOrderModule()
//                self.tabBarController?.navigationController!.pushViewController(VC, animated: true)
//                let vc = UIStoryboard.init(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: MenuVC.MyOrderVC) as! MyOrderVC
//                self.tabBarController?.navigationController!.pushViewController(vc, animated: true)
            }
        }
        tabBar.addSubview(view)
   
        view.addTap {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"sidemenu"), object: nil, userInfo: ["index":2])
            
//            if UserDefaultConfig.Token.isEmpty == false{
//                let vc = UIStoryboard.init(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: MenuVC.MyOrderVC) as! MyOrderVC
//                self.navigationController!.pushViewController(vc, animated: true)
//            } else {
//                let vc = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: LoginVCS.SigninVC) as! SigninVC
//                UserDefaultConfig.Login_Triggered_From = LoginTriggeredFrom.searchHome
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
        }
        view.layoutIfNeeded()
    }
    
    func setupVCs() {
            viewControllers = [
                createNavController(for: HomeVC.instantiate(storyboard: .main), title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "house")!),
                createNavController(for: BookingVC.instantiate(storyboard: .main), title: NSLocalizedString("Booking", comment: ""), image: UIImage(named: "Layer_x0020_1")!),
                createNavController(for: OfferVC.instantiate(storyboard: .main), title: NSLocalizedString("Offer", comment: ""), image: UIImage()),
                createNavController(for: ProfieVC.instantiate(storyboard: .main), title: NSLocalizedString("Profile", comment: ""), image: UIImage(named: "_2874105150416")!),
                createNavController(for: NeedHelpVC.instantiate(storyboard: .main), title: NSLocalizedString("Need Help", comment: ""), image: UIImage(named: "needhelImg")!)
            ]
        }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                      title: String,
                                         image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = image
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 12)]
        navController.tabBarItem.setTitleTextAttributes(attributes, for: .normal)
        //navController.navigationBar.prefersLargeTitles = true
        //rootViewController.navigationItem.title = title
        return navController
        
    }
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title)")
    }
}



extension UIView {

    func addShadow(offset: CGSize, color: UIColor, radius: CGFloat, opacity: Float) {
        layer.masksToBounds = false
        layer.shadowOffset = offset
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity

        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor =  backgroundCGColor
    }
}

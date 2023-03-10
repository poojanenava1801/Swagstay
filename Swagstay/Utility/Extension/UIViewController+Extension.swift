

import Foundation
import UIKit
import MBProgressHUD
import SideMenu


extension UIViewController{
    
    
    func setupShareButton() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        var centerButtonFrame = view.frame
        centerButtonFrame.origin.x = self.view.frame.width-60//self.view.bounds.width / 2 - centerButtonFrame.size.width/2
        view.backgroundColor = UIColor.white
            centerButtonFrame.origin.y = self.view.frame.height/2//self.view.bounds.height - centerButtonFrame.height - 20//45
        view.frame = centerButtonFrame
        view.layer.cornerRadius = view.frame.width / 2
        view.addShadow(offset: CGSize.init(width: 0, height: 3), color: UIColor.gray, radius: 2.0, opacity: 0.5)
        let image = UIImageView()
        view.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.widthAnchor.constraint(equalToConstant: 30).isActive = true
        image.heightAnchor.constraint(equalToConstant: 30).isActive = true
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        image.image = UIImage(named: "share123")
        image.tintColor = .black
        self.view.addSubview(view)
        view.addTap {
            print("common Share button Tap")
            let vc = ReferAndEarnVC.instantiate(storyboard: .main)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        view.layoutIfNeeded()
        self.view.bringSubviewToFront(view)
    }
    
//    func setupHeader(viewH:UIView) {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: viewH.frame.width, height: 40))
//        var centerButtonFrame = view.frame
//        centerButtonFrame.origin.x = 0//self.view.bounds.width / 2 - centerButtonFrame.size.width/2
//        view.backgroundColor = UIColor.white
//        centerButtonFrame.origin.y = (UIApplication.shared.keyWindow?.safeAreaInsets.top)!//self.view.bounds.height - centerButtonFrame.height - 20//45
//        view.frame = centerButtonFrame
//        //view.layer.cornerRadius = view.frame.width / 2
//        view.addShadow(offset: CGSize.init(width: 0, height: 1), color: UIColor.lightGray, radius: 2.0, opacity: 0.4)
//        let img = UIImageView(frame: CGRect(x: view.center.x-75, y: 5, width: 150, height: 30))
//        img.image = UIImage(named: "Swag_stay")
//        view.addSubview(img)
//
//
//        let image = UIImageView()
//        view.addSubview(image)
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.widthAnchor.constraint(equalToConstant: 30).isActive = true
//        image.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        image.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        image.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
//        image.image = UIImage(systemName: "sidebar.left")
//        image.tintColor = .gray
//
//        viewH.addSubview(view)
//        image.addTap {
//            print("common header button Tap")
//            let menu = SideMenuNavigationController.instantiate(storyboard: .main)
//            self.present(menu, animated: true, completion: nil)
//        }
//    }
    func appShare(msg:String) {
        let img = UIImage(named: "logo_small")//UIImage(named: "SoSampleImage")
        let messageStr = msg
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems:  [img!, messageStr], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @objc func updateSideMenu(_ notification: NSNotification){
        if let index = notification.userInfo?["index"] as? Int {
            self.tabBarController?.selectedIndex = index
        }
    }
    
    @IBAction func btnSideMenuTapped(_ sender: UIButton) {
        let menu = SideMenuNavigationController.instantiate(storyboard: .main)
        self.present(menu, animated: true, completion: nil)
    }
    
    
    @IBAction func btnNeedHelpTapped(_ sender: UIButton) {
        let menu = NeedHelp2VC.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(menu, animated: true)
    }
    
    @IBAction func btnGoToLoginTapped(_ sender: UIButton) {
        let vc = GetOTPVC.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func downLeftRightCorner(view:UIView,cornerRadius:CGFloat){
        view.clipsToBounds = true
        view.layer.cornerRadius = cornerRadius
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    
    
    
    func getRandomNumber(from:Int,to:Int) -> Int {
        return Int.random(in: from..<to)
    }
    
    @IBAction func navigationBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    static func instantiate(storyboard: UIStoryboard.Storyboard) -> Self {
        let storyboard = UIStoryboard(storyboard: storyboard)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: self.nameOfClass) as? Self else {
            fatalError("Could not find view controller with name \(self.nameOfClass)")
        }
        return viewController
    }
    
    func alertGlobly(message: String, title: String ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
//    func showAlertChatMessage() {
//        let alertController = UIAlertController.init(title: AppConstant.AppName, message: "You must Login to Chat", preferredStyle: .alert)
//        alertController.addAction(UIAlertAction.init(title: "Go Back", style: .cancel, handler: { (action) in
//        }))
//        alertController.addAction(UIAlertAction.init(title: "Login / Register", style: .default, handler: { (action) in
//
//            let vc = LoginVC.instantiate(storyboard: .login)
//            self.navigationController?.pushViewController(vc, animated: true)
//        }))
//        alertController.popoverPresentationController?.sourceView = view
//        self.navigationController?.present(alertController, animated: true, completion: nil)
//    }
    
    func shareText(text: String) {
        // set up activity view controller
        let textToShare = [ text ]
        
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func showIndicator() {
        let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        Indicator.label.text = "Loading..."
        Indicator.isUserInteractionEnabled = false
        Indicator.show(animated: true)
        self.view.isUserInteractionEnabled = false
        //self.currentTabBar?.view.isUserInteractionEnabled = false
    }
    
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
        self.view.isUserInteractionEnabled = true
        //self.currentTabBar?.view.isUserInteractionEnabled = true
        
    }
    
}

extension UIViewController{
    /// Status Bar Height
    func getStatusBarHeight() -> CGFloat {
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        return window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    }
    
    /// Display an alert view if the function is not implemented
    func showAlert(_ message: String, title: String? = nil){
        // Check if one has already presented
        if let currentAlert = self.presentedViewController as? UIAlertController {
            currentAlert.message = message
            return
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)


    }
    
    public func openLink(link: String) {
        if let url = URL(string: link) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
//    func showPopupView(title:String,detailTxt:String,videoUrl:String){
//        let popvc = UIStoryboard(name: "HelpPopUp", bundle: nil).instantiateViewController(withIdentifier: "PopupView") as! PopupView
//        popvc.strtitle = title
//        popvc.detailTxt = detailTxt
//        popvc.videoUrl = videoUrl
//        self.addChild(popvc)
//       // popvc.view.frame = self.view.frame
//        popvc.view.frame = self.view.bounds
//        self.view.addSubview(popvc.view)
//        popvc.didMove(toParent: self)
//        
//    }
}





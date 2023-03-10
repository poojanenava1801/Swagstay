//
//  ReferAndEarnVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 30/01/23.
//

import UIKit
import SwiftyJSON
import Toaster
import Social

class ReferAndEarnVC: UIViewController {
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var viewDash: UIView!
    @IBOutlet weak var viewCopy: UIView!
    
    @IBOutlet weak var lblReferCode: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        self.viewDash.addLineDashedStroke(pattern: [5, 5], radius: 15, color: UIColor.gray.cgColor)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
        if let user = Preference.shared.getUserDetails(){
            loginView.isHidden = true
            self.lblReferCode.text = user["reffer_code"].stringValue
            
            
        }else{
            loginView.isHidden = false
        }

    }
    
    func shareOnWatsapp(){
        let msg = "Hey there!\n\nI booked room with Swagstay Hotels and it was great experience, so thought about you to use this App for hotel room booking!"
        let urlWhats = "whatsapp://send?text=\(msg)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.openURL(whatsappURL as URL)
                } else {
                    // Cannot open whatsapp
                }
            }
        }
    }

    @IBAction func btnTelegramTapped(_ sender: UIButton) {
        let text = "Hey there!\n\nI booked room with Swagstay Hotels and it was great experience, so thought about you to use this App for hotel room booking!"
            let textShare = [text]
            let activityViewController = UIActivityViewController(activityItems: textShare , applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.present(activityViewController, animated: true, completion: nil)
    }
    @IBAction func btnWatsappTapped(_ sender: UIButton) {
        shareOnWatsapp()
    }
    @IBAction func btnFacebookTapped(_ sender: UIButton) {
        let vc = SLComposeViewController(forServiceType:SLServiceTypeFacebook)
        //vc?.add(UIImage.image)

        vc?.add(URL(string: "http://www.example.com/"))

        vc?.setInitialText("Initial text here.")

        self.present(vc!, animated: true, completion: nil)
    }
    @IBAction func btnCopyTapped(_ sender: UIButton) {
        UIPasteboard.general.string = self.lblReferCode.text!
        Toast(text: "Referral Code is Copied").show()
        
    }
    
    @IBAction func btnMoreTapped(_ sender: UIButton) {
        appShare(msg: "Hey there!\n\nI booked room with Swagstay Hotels and it was great experience, so thought about you to use this App for hotel room booking!")
    }
}
extension UIView {
    @discardableResult
    func addLineDashedStroke(pattern: [NSNumber]?, radius: CGFloat, color: CGColor) -> CALayer {
        let borderLayer = CAShapeLayer()

        borderLayer.strokeColor = color
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath

        layer.addSublayer(borderLayer)
        return borderLayer
    }
}

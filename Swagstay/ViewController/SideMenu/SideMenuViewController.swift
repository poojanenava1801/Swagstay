//
//  SideMenuViewController.swift
//  Kingpin
//
//  Created by Tarun Sahu on 16/11/21.
//

import UIKit
import SwiftyJSON
import MessageUI

class SideMenuViewController: UIViewController {
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    var arrMenuTitle  = ["Wallets","Your Saved properties","Refer and Earn","My Reward","Notification","Need Help","Expert PicksCorporate Solutions","List your property","Privacy"]
    var arrimage : [UIImage] = [UIImage(systemName:"person")!,UIImage(systemName: "person")!,UIImage(systemName: "person")!,UIImage(systemName: "person")!,UIImage(systemName: "person")!,UIImage(systemName: "person")!,UIImage(systemName: "person")!,UIImage(systemName: "person")!,UIImage(systemName: "person")!]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = Preference.shared.getUserDetails()
        {
            lblName.text = user["full_name"].stringValue
            lblEmail.text = user["user_moblie_no"].stringValue
//            if let url = URL(string:AppUrl.ImageUrl +  user["user_avatar"].stringValue)
//            {
//                imgProfile.sd_setImage(with: url, placeholderImage: UIImage(named: "kpLogo"))
//            }
        }
    }

    @IBAction func btnGoToProfileTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"sidemenu"), object: nil, userInfo: ["index":3])
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func string (_ dict:NSDictionary, _ key:String) -> String {
        if let title = dict[key] as? String {
            return "\(title)"
        } else if let title = dict[key] as? NSNumber {
            return "\(title)"
        } else {
            return ""
        }
    }
}

//MARK: tableview

extension SideMenuViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMenuTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuCell.nameOfClass, for: indexPath) as! MenuCell
        
        cell.lblMenuTitle.text = arrMenuTitle[indexPath.row]
        cell.imgMenu.image = arrimage[indexPath.row]
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let vc = WalletVC.instantiate(storyboard: .main)
            self.navigationController?.pushViewController(vc, animated: true)
            self.dismiss(animated: true, completion: nil)
        }else if indexPath.row == 1{
            let vc = FavoriteVC.instantiate(storyboard: .main)
            self.navigationController?.pushViewController(vc, animated: true)
            self.dismiss(animated: true, completion: nil)
        }else if indexPath.row == 2{
            let vc = ReferAndEarnVC.instantiate(storyboard: .main)
            self.navigationController?.pushViewController(vc, animated: true)
            self.dismiss(animated: true, completion: nil)
        }else if indexPath.row == 3{
            let vc = MyRewardVC.instantiate(storyboard: .main)
            self.navigationController?.pushViewController(vc, animated: true)
            self.dismiss(animated: true, completion: nil)
        }else if indexPath.row == 4{
            let vc = NotificationVC.instantiate(storyboard: .main)
            self.navigationController?.pushViewController(vc, animated: true)
            self.dismiss(animated: true, completion: nil)
        }else if indexPath.row == 5{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue:"sidemenu"), object: nil, userInfo: ["index":4])
            self.dismiss(animated: true, completion: nil)
        }else if indexPath.row == 6{
            let vc = CorporateSolutionVC.instantiate(storyboard: .main)
            self.navigationController?.pushViewController(vc, animated: true)
            self.dismiss(animated: true, completion: nil)
        }else if indexPath.row == 7{
            let vc = ListYourPropertyVC.instantiate(storyboard: .main)
            self.navigationController?.pushViewController(vc, animated: true)
            self.dismiss(animated: true, completion: nil)
        }else if indexPath.row == 8{
            let vc = PrivacyVC.instantiate(storyboard: .main)
            self.navigationController?.pushViewController(vc, animated: true)
            self.dismiss(animated: true, completion: nil)
        }
    }
}

//MARK: MenuCell

class MenuCell: UITableViewCell {
    @IBOutlet weak var lblMenuTitle: UILabel!
    @IBOutlet weak var imgMenu: UIImageView!
}

////MARK: Functions
//extension SideMenuViewController: MFMailComposeViewControllerDelegate
//{
//    func openContactUs() {
//        AdjustManager.shared.trackEvent("rhwaxv")
//        if MFMailComposeViewController.canSendMail() {
//            let mail = MFMailComposeViewController()
//            mail.mailComposeDelegate = self
//            mail.setToRecipients([StaticString.infoMail])
//            mail.setMessageBody("", isHTML: false)
//            present(mail, animated: true)
//        } else {
//            openLink(link:StaticString.ContactUs)
//        }
//    }
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        controller.dismiss(animated: true)
//    }
//
//    func shareText()
//    {
//        AdjustManager.shared.trackEvent("vkqsjk")
//        let text = "\(AppUrl.GetAppUrl)"
//            self.shareText(text: text)
//    }
//
//}

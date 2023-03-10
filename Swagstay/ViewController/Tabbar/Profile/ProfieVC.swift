//
//  ProfieVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 29/01/23.
//

import UIKit

class ProfieVC: UIViewController {
    @IBOutlet weak var viewName: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNumber: UILabel!
    
    @IBOutlet weak var lblExperience: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        headerView.addShadow(offset: CGSize.init(width: 0, height: 1), color: UIColor.lightGray, radius: 2.0, opacity: 0.4)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateSideMenu(_:)), name: NSNotification.Name(rawValue:"sidemenu"), object: nil)
        lblExperience.text = "Add details for better & personlized booking\nexperience"
        setupShareButton()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        
        if let user = Preference.shared.getUserDetails()
        {
            loginView.isHidden = true
            lblName.text = user["full_name"].stringValue
            lblNumber.text = user["user_moblie_no"].stringValue
//            if let url = URL(string:AppUrl.ImageUrl +  user["user_avatar"].stringValue)
//            {
//                imgProfile.sd_setImage(with: url, placeholderImage: UIImage(named: "kpLogo"))
//            }
        }else{
            loginView.isHidden = false
        }
    }

    @IBAction func btnLogOutTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "", message: "Are you sure you want to log out", preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            Preference.shared.clearData()
            let vc = GetOTPVC.instantiate(storyboard: .main)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }

        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    @IBAction func btnPrivacyTapped(_ sender: UIButton) {
        let vc = PrivacyVC.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnSavedPropertyTapped(_ sender: UIButton) {
        let vc = FavoriteVC.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnGSTINTapped(_ sender: Any) {
        let vc = GSTINVC.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func btnWalletTapped(_ sender: UIButton) {
        let vc = WalletVC.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnPersonalInfoTapped(_ sender: UIButton) {
        let vc = ProfileUpdateViewController.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//
//  GetOTPVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 28/01/23.
//

import UIKit
import CoreLocation

class GetOTPVC: UIViewController {

    @IBOutlet weak var btnZip: UIButton!
    @IBOutlet weak var tfMobileNumber: UITextField!
    var locManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        locManager.requestWhenInUseAuthorization()
    }
    
    @IBAction func btnGetOTPTapped(_ sender: UIButton) {
        getOtp()
        
    }
    
    @IBAction func btnSighupLaterTapped(_ sender: UIButton) {
        let home = TabBarVC()
        UIApplication.shared.windows.first?.rootViewController = home
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}

extension GetOTPVC{
    func getOtp(){
        
        let param = ["mobile_no":tfMobileNumber.text ?? "",
                     "key_secret":"swagstayhotel_key@2022",
                     "user_email":"",
                     "user_name":"",
                     "user_id":"",
                     "referral_id":"",
                     "zip_code":"",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? ""] as [String:Any]
        
        HttpUtility.shared.post(requestUrl:AppUrl.getOtp, param: param) { result in
            print(result)
            if result.count>0{
                Preference.shared.setUserDetails(data: result[0])
                let vc = VerifyOTPVC.instantiate(storyboard: .main)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            

            /*
             0~@~[
                 {
                     "full_name": "ahad khalid",
                     "user_email": "ahadkhalid117@gmail.com",
                     "user_moblie_no": "8770502353",
                     "reffer_code": "cJwyXb",
                     "zip_code": "+91",
                     "user_otp": "8918",
                     "user_flag": "1",
                     "cd_id": "14"
                 }
             ]
             */
            /*
             Note 1 time me mobile no send karna hai second time agar user_flag 0 aata hai to profile section dekna hai and data update karna hai same api me

             */
        }
        
    }
}

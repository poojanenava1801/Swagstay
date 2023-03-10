//
//  PrivacyVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 30/01/23.
//

import UIKit
import WebKit

class PrivacyVC: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        getPrivacy()
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true

    }

}

extension PrivacyVC{
    func getPrivacy(){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? ""]

        HttpUtility.shared.postPrivacy(requestUrl: AppUrl.privacyLink, param: param) { result in
            print(result)
            
            self.webView.loadHTMLStringWithMagic(content: result, baseURL: nil)

           
        }
        
    }
}

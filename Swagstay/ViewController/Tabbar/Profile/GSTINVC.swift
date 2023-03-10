//
//  GSTINVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 02/03/23.
//

import UIKit
import Toaster

class GSTINVC: UIViewController {
    @IBOutlet weak var tfEntityName: UITextField!
    @IBOutlet weak var tfGSTNO: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfMobile: UITextField!
    @IBOutlet weak var TfEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        getProfile()
    }
    
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        updateGstUrl()
    }
    
}

extension GSTINVC{
    
    func getProfile(){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? "",
                     "flag":"1"]
        
        HttpUtility.shared.post(requestUrl: AppUrl.profileDataUrl, param: param) { result in
            print(result)
            if result.count>0{
                self.tfEntityName.text = result[0]["profile_data"][0].dictionaryValue["legal_entity_name"]?.stringValue
                self.tfGSTNO.text = result[0]["profile_data"][0].dictionaryValue["gst_number"]?.stringValue
                self.tfAddress.text = result[0]["profile_data"][0].dictionaryValue["gst_address"]?.stringValue
                self.tfMobile.text = result[0]["profile_data"][0].dictionaryValue["gst_mobile_no"]?.stringValue
                self.TfEmail.text = result[0]["profile_data"][0].dictionaryValue["gst_email"]?.stringValue
            }
        }
        
    }
    
    func updateGstUrl(){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? "",
                     "legal_entity_name":tfEntityName.text ?? "",
                     "gst_number":tfGSTNO.text ?? "",
                     "your_address":tfAddress.text ?? "",
                     "gst_email":TfEmail.text ?? "",
                     "gst_mobile_no":tfMobile.text ?? "",
                     "booking_id":"",
                     "Book_id":"",
                     "HotelID":"",
                     "hotel_id":""]

        HttpUtility.shared.post(requestUrl: AppUrl.updateGstUrl, param: param) { result in
            print(result)
            Toast(text: result["msg"].stringValue).show()
           
        }
        
    }
}

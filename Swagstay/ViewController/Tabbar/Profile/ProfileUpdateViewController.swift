//
//  ProfileUpdateViewController.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 02/03/23.
//

import UIKit
import Toaster

class ProfileUpdateViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnMarried: UIButton!
    @IBOutlet weak var btnUnmerried: UIButton!
    @IBOutlet weak var tfCity: UITextField!
    @IBOutlet weak var tfBirthday: UITextField!
    
    var gender = ""
    var MeritalStatus = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        getProfile()
    }
    
    @IBAction func btnSaveTapped(_ sender: UIButton) {
        updateProfile()
    }
    
    @IBAction func btnMaleTapped(_ sender: UIButton) {
        gender = "Male"
        btnMale.backgroundColor = UIColor(hexString: "479D9A")
        btnMale.tintColor = .white
        btnMale.setTitleColor(.white, for: .normal)
        btnFemale.setTitleColor(.lightGray, for: .normal)
        btnFemale.backgroundColor = .white
        btnFemale.tintColor = .lightGray
    }
    @IBAction func btnFemaleTapped(_ sender: UIButton) {
        gender = "Female"
        btnFemale.backgroundColor = UIColor(hexString: "479D9A")
        btnFemale.tintColor = .white
        btnFemale.setTitleColor(.white, for: .normal)
        btnMale.setTitleColor(.lightGray, for: .normal)
        btnMale.backgroundColor = .white
        btnMale.tintColor = .lightGray
    }
    @IBAction func btnMarriedTapped(_ sender: UIButton) {
        MeritalStatus = "Married"
        btnMarried.backgroundColor = UIColor(hexString: "479D9A")
        btnMarried.tintColor = .white
        btnMarried.setTitleColor(.white, for: .normal)
        btnUnmerried.setTitleColor(.lightGray, for: .normal)
        btnUnmerried.backgroundColor = .white
        btnUnmerried.tintColor = .lightGray
    }
    @IBAction func btnUnmarriedTapped(_ sender: UIButton) {
        MeritalStatus = "Unmarried"

        btnUnmerried.backgroundColor = UIColor(hexString: "479D9A")
        btnUnmerried.tintColor = .white
        btnUnmerried.setTitleColor(.white, for: .normal)
        btnMarried.setTitleColor(.lightGray, for: .normal)
        btnMarried.backgroundColor = .white
        btnMarried.tintColor = .lightGray
    }
   
}

extension ProfileUpdateViewController{
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
                self.tfFullName.text = result[0]["profile_data"][0].dictionaryValue["full_name"]?.stringValue
                self.tfEmail.text = result[0]["profile_data"][0].dictionaryValue["user_email"]?.stringValue
                self.tfCity.text = result[0]["profile_data"][0].dictionaryValue["city_of_residence"]?.stringValue
                self.tfBirthday.text = result[0]["profile_data"][0].dictionaryValue["user_dob"]?.stringValue
                
                if result[0]["profile_data"][0].dictionaryValue["user_sex"]?.stringValue.lowercased() == "female"{
                    self.btnFemaleTapped(self.btnFemale)
                }else{
                    self.btnMaleTapped(self.btnMale)
                }
                
                if result[0]["profile_data"][0].dictionaryValue["married_status"]?.stringValue.lowercased() == "unmarried"{
                    self.btnUnmarriedTapped(self.btnUnmerried)
                }else{
                    self.btnMarriedTapped(self.btnMarried)
                }
                
            }
        }
        
    }
    
    func updateProfile(){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? "",
                     "gender":self.gender,
                     "married_status":self.MeritalStatus,
                     "edit_name":self.tfFullName.text ?? "",
                     "edit_email":self.tfEmail.text ?? "",
                     "city_of_residence":self.tfCity.text ?? "",
                     "city_on_your_id_card":self.tfCity.text ?? "",
                     "your_birthday":self.tfBirthday.text ?? ""]
        
        HttpUtility.shared.post(requestUrl: AppUrl.updateProfileUrl, param: param) { result in
            print(result)
            Toast(text: result["msg"].stringValue).show()
           
        }
        
    }
}

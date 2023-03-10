//
//  PromoCodeVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 02/03/23.
//

import UIKit
import Toaster
import SwiftyJSON

protocol SavedPromoCodeDelegate: AnyObject {
    func getApplyPromoCode(dict: JSON)
}

class PromoCodeVC: UIViewController {

    @IBOutlet weak var tblPromoCode: UITableView!
    @IBOutlet weak var tfPromoCode: UITextField!
    
    var hotelId = ""
    var arrPromoCodes = JSON().arrayValue
    var delegate:SavedPromoCodeDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblPromoCode.register(UINib(nibName: "PromoTableViewCell", bundle: nil), forCellReuseIdentifier: "PromoTableViewCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        getOffersList()
        //getAllPromoCodes()
    }

    @IBAction func btnApplyTapped(_ sender: UIButton) {
        //promocodeOrderUser(coupanName: tfPromoCode.text ?? "", TotalAmount: tfPromoCode.text?.replacingOccurrences(of: "SWAG", with: "") ?? "")
    }
    

}

extension PromoCodeVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrPromoCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromoTableViewCell", for: indexPath) as! PromoTableViewCell
        cell.lblDescription.text = "\(self.arrPromoCodes[indexPath.row]["disc_msg"].stringValue )"
        cell.btnPromoCode.setTitle(self.arrPromoCodes[indexPath.row]["promo_code"].stringValue, for: .normal)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //   promocodeOrderUser(coupanName: self.arrPromoCodes[indexPath.row]["promo_code"].stringValue, TotalAmount: self.arrPromoCodes[indexPath.row]["min_amount"].stringValue)
    }
    
    
}

extension PromoCodeVC{
    func getOffersList(){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? "",
                     "hotel_id":hotelId]

        HttpUtility.shared.post(requestUrl: AppUrl.offersList, param: param) { result in
            print(result)
            if result.count>0{
                self.tblPromoCode.isHidden = false
                self.arrPromoCodes = result.arrayValue
                self.tblPromoCode.reloadData()
            }else{
                self.tblPromoCode.isHidden = true
            }

           
        }
        
    }
    
    
    func getAllPromoCodes(){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? "",
                     "longitude":"",
                     "latitude":"",
                     "flag":"1"]

        HttpUtility.shared.post(requestUrl:AppUrl.promocodeAll, param: param) { result in
            print(result)
//            if result.count>0{
//                self.tblPromoCode.isHidden = false
//                self.arrPromoCodes = result[0]["recommend_promocode"].arrayValue
//                self.tblPromoCode.reloadData()
//            }else{
//                self.tblPromoCode.isHidden = true
//            }
        }
    }
    
    func promocodeOrderUser(coupanName:String,TotalAmount:String){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? "",
                     "hotel_id":hotelId,
                     "coupon_name":coupanName,
                     "total_amount":TotalAmount]

        
        HttpUtility.shared.post(requestUrl: AppUrl.promocodeOrderUser, param: param) { result in
            print(result)
            if result["error"].boolValue{
                Toast(text: result["msg"].stringValue).show()
            }else{
                let dict = ["coupon_name":result["promo_code"].stringValue,
                            "total_amount":result["totaldiscount"].stringValue]
                self.delegate.getApplyPromoCode(dict: JSON(dict))
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

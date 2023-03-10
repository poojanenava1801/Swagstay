//
//  ConfirmBookingVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 03/03/23.
//

import UIKit
import SwiftyJSON
import SDWebImage
import Toaster

class ConfirmBookingVC: UIViewController {

    @IBOutlet weak var collViewAmenities: UICollectionView!
    
    @IBOutlet weak var lblHiii: UILabel!
    
    @IBOutlet weak var lblBookingName: UILabel!
    
    @IBOutlet weak var lblHotelName: UILabel!
    @IBOutlet weak var lblHotelAddress: UILabel!
    @IBOutlet weak var imgHotel: UIImageView!
    
    @IBOutlet weak var viewBookingDetail: UIView!
    @IBOutlet weak var lblBookingDetail: UILabel!
    @IBOutlet weak var lblCurrentStatus: UILabel!
    
    @IBOutlet weak var lblCheckOutDate: UILabel!
    @IBOutlet weak var lblCheckInDate: UILabel!
    @IBOutlet weak var lblTotalPayable: UILabel!
    @IBOutlet weak var lblRoomType: UILabel!
    @IBOutlet weak var lblAdvancedAmount: UILabel!
    @IBOutlet weak var lblOtaAmount: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var svCall: UIStackView!
    
    @IBOutlet weak var viewCancel: UIView!
    
    @IBOutlet weak var viewPayNow: UIView!
    @IBOutlet weak var viewModifyGuest: UIView!
    @IBOutlet weak var viewCoupleFriendly: UIView!
    @IBOutlet weak var lblPaymentvVew: UILabel!
    
    @IBOutlet weak var viewGuestName: UIView!
    @IBOutlet weak var tfGuestName: UITextField!
    var dictBookingDetail = JSON().dictionaryValue
    var dictHotel = JSON()
    var tag = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collViewAmenities.register(UINib(nibName: "FacilitiesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FacilitiesCollectionViewCell")
        viewGuestName.addTap {
            self.viewGuestName.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        if tag == "upcomming"{
            lblBookingName.text = "Your booking is confirmed"
            viewBookingDetail.isHidden = false
            svCall.isHidden = false
            viewCancel.isHidden = false
            viewModifyGuest.isHidden = false
            viewPayNow.isHidden = false
        }else if tag == "inhouse"{
            lblBookingName.text = "Your booking is confirmed"
            viewBookingDetail.isHidden = false
            svCall.isHidden = false
            viewCancel.isHidden = false
            viewModifyGuest.isHidden = false
            viewPayNow.isHidden = false
        }else if tag == "complete"{
            lblBookingName.text = "Your booking is completed"
            viewBookingDetail.isHidden = false
            svCall.isHidden = false
            viewCancel.isHidden = false
            viewModifyGuest.isHidden = false
            viewPayNow.isHidden = false
        }else if tag == "cancelled"{
            lblBookingName.text = "Your booking is Cancel"
            viewBookingDetail.isHidden = true
            svCall.isHidden = true
            
            viewCancel.isHidden = true
            viewModifyGuest.isHidden = true
            viewPayNow.isHidden = true
        }
        
        getBookingDetailsAll(hotelID: dictHotel["HotelID"].stringValue, hotelid: dictHotel["hotel_id"].stringValue, bookid: dictHotel["book_id"].stringValue, bookingid: dictHotel["booking_id"].stringValue)
    }
   
    @IBAction func btnUpdateGuestNameTapped(_ sender: UIButton) {
        if tfGuestName.text?.count ?? 0>0{
            updateGuestName()
        }else{
            Toast(text: "Please Enter the Guest Name").show()
        }
        
       
    }
    @IBAction func btnCopyTapped(_ sender: UIButton) {
        UIPasteboard.general.string = self.lblBookingDetail.text!
        Toast(text: "Referral Code is Copied").show()
    }
    
    @IBAction func btnCallTapped(_ sender: UIButton) {
        let phonNo = dictBookingDetail["call_hotel_no"]?.stringValue
        if let url = URL(string: "tel://\(phonNo)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    @IBAction func btnShareTapped(_ sender: UIButton) {
        appShare(msg: dictBookingDetail["share_link"]?.stringValue ?? "")
    }
    @IBAction func btnDirectionTapped(_ sender: UIButton) {
        let lat = dictBookingDetail["hotel_details"]?[0].dictionaryValue["latitude"]?.stringValue ?? ""
        let long = dictBookingDetail["hotel_details"]?[0].dictionaryValue["longitude"]?.stringValue ?? ""
        
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(NSURL(string:"comgooglemaps://?saddr=&daddr=\(lat),\(long)&directionsmode=driving")! as URL)
            } else {
                UIApplication.shared.openURL(NSURL(string:"comgooglemaps://?saddr=&daddr=\(lat),\(long)&directionsmode=driving")! as URL)
            }
            
        } else {
            print("Can't use comgooglemaps://")
        }
    }
    
    @IBAction func btnGSTINTapped(_ sender: UIButton) {
        let vc = GSTINVC.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnCancelBookingTapped(_ sender: UIButton) {
        cancelBooking()
    }
    @IBAction func btnModifyGuestNameTapped(_ sender: UIButton) {
        viewGuestName.isHidden = false
        
    }
    @IBAction func btnCancellationPolicyTapped(_ sender: UIButton) {
        let vc = PrivacyVC.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnHotelRulesTapped(_ sender: UIButton) {
        let vc = PrivacyVC.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ConfirmBookingVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dictBookingDetail["facility_list"]?.arrayValue.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesCollectionViewCell", for: indexPath) as! FacilitiesCollectionViewCell
        
        let data = dictBookingDetail["facility_list"]?[indexPath.row]
        
        if let imgUrl = URL(string: (dictBookingDetail["facility_image_link"]?.stringValue ?? "")+(data?["animatie_code"].stringValue ?? "")){
            cell.imgFacilities.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "logo_placeholder"))
            
        }
        
        cell.lblFacilities.text = data?["animatie_name"].stringValue ?? ""
            
            return cell
        
    }
    
}

extension ConfirmBookingVC{
    func getBookingDetailsAll(hotelID:String,hotelid:String,bookid:String,bookingid:String){
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
                     "hotel_id":hotelid,
                     "HotelID":hotelID,
                     "book_id":bookid,
                     "booking_id":bookingid]

        HttpUtility.shared.post(requestUrl:AppUrl.bookingDetailsAll, param: param) { result in
            print(result)
            if result.count>0{
                self.viewGuestName.isHidden = true
                self.dictBookingDetail = result[0].dictionaryValue
                
                if result[0]["booking_details"].count>0 && result[0]["hotel_details"].count>0{
                    
                    let dicBookingInfoDetail = result[0]["booking_details"][0].dictionaryValue
                    
                    let dicHotelInfoDetail = result[0]["hotel_details"][0].dictionaryValue
                    
                    self.lblHiii.text = "Hii \(dicBookingInfoDetail["per_name"]?.stringValue ?? "")"
                    
                    
                    if let imgUrl = URL(string: result[0]["hotel_image_link"].stringValue+(dicHotelInfoDetail["image_name"]?.stringValue ?? "")){
                        self.imgHotel.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "logo_placeholder"))
                    }
                    
                    self.lblHotelName.text = dicHotelInfoDetail["hotel_name"]?.stringValue ?? ""
                    self.lblHotelAddress.text = "\(dicHotelInfoDetail["address"]?.stringValue ?? "")\n\(dicHotelInfoDetail["city_name"]?.stringValue ?? "")"
                    
                    self.lblBookingDetail.text = dicBookingInfoDetail["booking_id"]?.stringValue ?? ""
                    
                    self.lblCurrentStatus.text = dicBookingInfoDetail["checkin_status"]?.stringValue ?? ""
                    
                    self.lblUserName.text = dicBookingInfoDetail["per_name"]?.stringValue ?? ""
                    
                    self.lblAdvancedAmount.text = "\(result[0]["rupees_icon"].stringValue) \(dicBookingInfoDetail["advacnce_amount"]?.stringValue ?? "")"
                    
                    self.lblOtaAmount.text = "\(result[0]["rupees_icon"].stringValue) \(dicBookingInfoDetail["ota_amount"]?.stringValue ?? "")"
                    
                    self.lblTotalPayable.text = "\(result[0]["rupees_icon"].stringValue) \(dicBookingInfoDetail["balance_amount"]?.stringValue ?? "")"
                    
                    self.lblPaymentvVew.text = "\(result[0]["rupees_icon"].stringValue) \(dicBookingInfoDetail["balance_amount"]?.stringValue ?? "")"
                    
                    
                    self.lblRoomType.text = dicBookingInfoDetail["room_type"]?.stringValue ?? ""
                    
                    self.lblCheckInDate.text = dicBookingInfoDetail["check_in_date"]?.stringValue ?? ""
                    
                    self.lblCheckOutDate.text = dicBookingInfoDetail["check_out_date"]?.stringValue ?? ""
                    
                    if dicHotelInfoDetail["couple_friendly"]?.stringValue == "1"{
                        self.viewCoupleFriendly.isHidden = false
                    }else{
                        self.viewCoupleFriendly.isHidden = true
                    }
                    
                    self.collViewAmenities.reloadData()
                }
            }
        }
    }
    
    func getCancellationPolicy(){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":""]

        HttpUtility.shared.post(requestUrl:AppUrl.cancellationPolicy, param: param) { result in
            print(result)
           
           
        }
        
    }
    
    func cancelBooking(){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? "",
                     "hotel_id":dictHotel["hotel_id"].stringValue,
                     "HotelID":dictHotel["HotelID"].stringValue,
                     "booking_id":dictHotel["booking_id"].stringValue]

        HttpUtility.shared.post(requestUrl: AppUrl.cancelBooking, param: param) { result in
            print(result)
            Toast(text: result["msg"].stringValue).show()
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func updateGuestName(){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? "",
                     "hotel_id":dictHotel["hotel_id"].stringValue,
                     "HotelID":dictHotel["HotelID"].stringValue,
                     "booking_id":dictHotel["booking_id"].stringValue,
                     "guest_name":self.tfGuestName.text!]

        HttpUtility.shared.post(requestUrl: AppUrl.updateGuestName, param: param) { result in
            print(result)
            Toast(text: result["msg"].stringValue).show()
            self.getBookingDetailsAll(hotelID: self.dictHotel["HotelID"].stringValue, hotelid: self.dictHotel["hotel_id"].stringValue, bookid: self.dictHotel["book_id"].stringValue, bookingid: self.dictHotel["booking_id"].stringValue)
            
        }
        
    }
}

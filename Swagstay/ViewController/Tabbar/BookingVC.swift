//
//  BookingVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 29/01/23.
//

import UIKit
import SwiftyJSON

class BookingVC: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var loginView: UIView!
    
    @IBOutlet weak var btnUpcomming: UIButton!
    @IBOutlet weak var btnInhouse: UIButton!
    @IBOutlet weak var btnCancelled: UIButton!
    @IBOutlet weak var btnCompleted: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var arrUpcomming = JSON().arrayValue
    var arrInhouse = JSON().arrayValue
    var arrCompleted = JSON().arrayValue
    var arrCancelled = JSON().arrayValue
    var tag = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        headerView.addShadow(offset: CGSize.init(width: 0, height: 1), color: UIColor.lightGray, radius: 2.0, opacity: 0.4)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateSideMenu(_:)), name: NSNotification.Name(rawValue:"sidemenu"), object: nil)
        tableView.register(UINib(nibName: "BookingTableViewCell", bundle: nil), forCellReuseIdentifier: "BookingTableViewCell")
        setupShareButton()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let _ = Preference.shared.getUserCdId(){
            loginView.isHidden = true
            getBookingAll()
        }else{
            loginView.isHidden = false
        }
    
        
        self.tabBarController?.tabBar.isHidden = false

    }

    @IBAction func btnActionTapped(_ sender: UIButton) {
        tag = sender.tag
        self.tableView.reloadData()
        if sender.tag == 1{
            btnUpcomming.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
            btnInhouse.setTitleColor(.label, for: .normal)
            btnCompleted.setTitleColor(.label, for: .normal)
            btnCancelled.setTitleColor(.label, for: .normal)
            if arrUpcomming.count > 0{
                tableView.isHidden = false
            }else{
                tableView.isHidden = true
            }
            //tableView.isHidden = false
        }else if sender.tag == 2{
            btnInhouse.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
            btnUpcomming.setTitleColor(.label, for: .normal)
            btnCompleted.setTitleColor(.label, for: .normal)
            btnCancelled.setTitleColor(.label, for: .normal)
            if arrInhouse.count > 0{
                tableView.isHidden = false
            }else{
                tableView.isHidden = true
            }
            //tableView.isHidden = true
        }else if sender.tag == 3{
            btnCompleted.setTitleColor(.systemGreen, for: .normal)
            btnInhouse.setTitleColor(.label, for: .normal)
            btnUpcomming.setTitleColor(.label, for: .normal)
            btnCancelled.setTitleColor(.label, for: .normal)
            if arrCompleted.count > 0{
                tableView.isHidden = false
            }else{
                tableView.isHidden = true
            }
            //tableView.isHidden = true
        }else{
            btnCancelled.setTitleColor(.systemRed, for: .normal)
            btnInhouse.setTitleColor(.label, for: .normal)
            btnCompleted.setTitleColor(.label, for: .normal)
            btnUpcomming.setTitleColor(.label, for: .normal)
            if arrCancelled.count > 0{
                tableView.isHidden = false
            }else{
                tableView.isHidden = true
            }
            //tableView.isHidden = true
        }
        
    }
    
    

}

extension BookingVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tag == 1{
            return self.arrUpcomming.count
        }else if tag == 2{
            return self.arrInhouse.count
        }else if tag == 3{
            return self.arrCompleted.count
        }else{
            return self.arrCancelled.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookingTableViewCell") as! BookingTableViewCell
        var data = JSON()
        if tag == 1{
            data =  self.arrUpcomming[indexPath.row]
        }else if tag == 2{
            data =  self.arrInhouse[indexPath.row]
        }else if tag == 3{
            data =  self.arrCompleted[indexPath.row]
        }else{
            data =  self.arrCancelled[indexPath.row]
        }
        
        cell.lblDateGuest.text = data["total_rating"].stringValue
        cell.lblName.text = data["hotel_name"].stringValue
        cell.lblAddress.text = data["small_description"].stringValue



        if let imgUrl = URL(string: AppUrl.hotelImageUrl+data["image_name"].stringValue){
            cell.imgHotel.sd_setImage(with: imgUrl)
        }
        
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ConfirmBookingVC.instantiate(storyboard: .main)
        if tag == 1{
            vc.dictHotel =  self.arrUpcomming[indexPath.row]
            vc.tag = "upcomming"
        }else if tag == 2{
            vc.dictHotel =  self.arrInhouse[indexPath.row]
            vc.tag = "inhouse"
        }else if tag == 3{
            vc.dictHotel =  self.arrCompleted[indexPath.row]
            vc.tag = "complete"
        }else{
            vc.dictHotel =  self.arrCancelled[indexPath.row]
            vc.tag = "cancelled"
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension BookingVC{
    func getBookingAll(){
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

        HttpUtility.shared.post(requestUrl:AppUrl.bookingAll, param: param) { result in
            print(result)
            if result.count>0{
                
                self.arrUpcomming = result[0]["upcomming_list"].arrayValue
                self.arrCompleted = result[0]["completed_list"].arrayValue
                self.arrInhouse = result[0]["process_list"].arrayValue
                self.arrCancelled = result[0]["cancelled_list"].arrayValue
                self.tableView.reloadData()
                if self.arrUpcomming.count > 0{
                    self.tableView.isHidden = false
                }else{
                    self.tableView.isHidden = true
                }
            }
        }
    }
}

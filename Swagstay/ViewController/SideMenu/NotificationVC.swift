//
//  NotificationVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 30/01/23.
//

import UIKit
import SwiftyJSON

class NotificationVC: UIViewController {

    @IBOutlet weak var tblNotification: UITableView!
    var arrNoti = JSON().arrayValue
    override func viewDidLoad() {
        super.viewDidLoad()

        tblNotification.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        getNotification()
    }
   

}
extension NotificationVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrNoti.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        cell.lblTitle.text = "\(self.arrNoti[indexPath.row]["title"].stringValue )"
        cell.lblDate.text = "\(self.arrNoti[indexPath.row]["entry_date"].stringValue )"
        cell.lblMsg.text = "\(self.arrNoti[indexPath.row]["message"].stringValue )"

        return cell
    }
    
    
}

extension NotificationVC{
    func getNotification(){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? "",
                     "flag":"1"]
        
        HttpUtility.shared.post(requestUrl: AppUrl.viewNotification, param: param) { result in
            print(result)
            if result.count>0{
                self.arrNoti = result[0]["notification_data"].arrayValue
                self.tblNotification.reloadData()
            }
           
        }
        
    }
}

//
//  MyRewardVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 30/01/23.
//

import UIKit
import SwiftyJSON

class MyRewardVC: UIViewController {

    @IBOutlet weak var tblReward: UITableView!
    @IBOutlet weak var loginView: UIView!

    var walletDict = JSON().dictionaryValue
    override func viewDidLoad() {
        super.viewDidLoad()

        tblReward.register(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionTableViewCell")
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        if let _ = Preference.shared.getUserCdId(){
            loginView.isHidden = true
            getWalletDetailAll()
            
        }else{
            loginView.isHidden = false
        }
        
        
    }

}

extension MyRewardVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath) as! TransactionTableViewCell
        let data = self.walletDict["wallethis_list"]?.arrayValue[indexPath.row].dictionaryValue
        let conDate = (data?["coverted_date"]?.stringValue)?.components(separatedBy: " ")
        if conDate?.count == 3{
            cell.lblDate.text = "\(conDate?[1] ?? "")"
            cell.lblMonth.text = "\(conDate?[0] ?? "")"
            cell.lblYear.text = "\(conDate?[2] ?? "")"
        }

        cell.lblThroughDescription.text = "\(data?["through"]?.stringValue ?? "")"
        if data?["flag"]?.stringValue ?? "" == "c"{
            cell.lblAmount.text = "+\(self.walletDict["rupees_icon"]?.stringValue ?? "")\(data?["amount"]?.stringValue ?? "")"
        }else{
            cell.lblAmount.text = "-\(self.walletDict["rupees_icon"]?.stringValue ?? "")\(data?["amount"]?.stringValue ?? "")"
        }
        return cell
    }
    
    
}

extension MyRewardVC{
    func getWalletDetailAll(){
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

        HttpUtility.shared.post(requestUrl: AppUrl.walletDetailsAll, param: param) { result in
            if result.count>0{
                self.walletDict = result[0].dictionaryValue
                self.tblReward.reloadData()
            }
            
        }
        
    }
}

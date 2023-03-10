//
//  WalletVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 30/01/23.
//

import UIKit
import SwiftyJSON

class WalletVC: UIViewController {
    @IBOutlet weak var loginView: UIView!

    @IBOutlet weak var lblCreditAmount: UILabel!
    @IBOutlet weak var tblTransaction: UITableView!
    
    @IBOutlet weak var viewCornerBottom: UIView!
    @IBOutlet weak var lblLinkedTo: UILabel!
    @IBOutlet weak var tblTransactionHeight: NSLayoutConstraint!
    
    var walletDict = JSON().dictionaryValue
    override func viewDidLoad() {
        super.viewDidLoad()
        tblTransaction.register(UINib(nibName: "TransactionTableViewCell", bundle: nil), forCellReuseIdentifier: "TransactionTableViewCell")
        self.tblTransactionHeight?.constant = CGFloat.greatestFiniteMagnitude
        self.tblTransaction.reloadData()
        self.tblTransaction.layoutIfNeeded()
        self.tblTransactionHeight?.constant = self.tblTransaction.contentSize.height
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        viewCornerBottom.roundCorners([.bottomRight,.bottomLeft], radius: 50.0)
        if let userData = Preference.shared.getUserDetails(){
            loginView.isHidden = true
            self.lblLinkedTo.text = "Linked to \(userData["user_moblie_no"].stringValue)"
            getWalletDetail()
        }else{
            loginView.isHidden = false
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        

    }
    
    func appRefer() {
        let img = UIImage(named: "AppTopIcon")//UIImage(named: "SoSampleImage")
        let messageStr = "\(self.walletDict["rupees_icon"]?.stringValue ?? "")"
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems:  [img!, messageStr], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivity.ActivityType.print, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.postToVimeo]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func btnCreditTapped(_ sender: UIButton) {
        let vc = AddWalletViewController.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnReferTapped(_ sender: UIButton) {
        appRefer()
    }
    @IBAction func btn3BookingTapped(_ sender: UIButton) {
        appRefer()
    }
}

extension WalletVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.walletDict["wallethis_list"]?.count ?? 0
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

extension WalletVC{
    func getWalletDetail(){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? ""]
        
        HttpUtility.shared.post(requestUrl: AppUrl.walletDetails, param: param) { result in
            print(result)
            if result.count>0{
                self.walletDict = result[0].dictionaryValue
                Preference.shared.setWalletAmount(sport: self.walletDict["wallet_amount"]?.stringValue ?? "")
                self.lblCreditAmount.text = "\(self.walletDict["rupees_icon"]?.stringValue ?? "") \(self.walletDict["wallet_amount"]?.stringValue ?? "")"
                self.tblTransactionHeight?.constant = CGFloat.greatestFiniteMagnitude
                self.tblTransaction.reloadData()
                self.tblTransaction.layoutIfNeeded()
                self.tblTransactionHeight?.constant = self.tblTransaction.contentSize.height
            }
        }
    }
    
   
}

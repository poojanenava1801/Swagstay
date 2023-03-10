//
//  SearchVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 08/03/23.
//

import UIKit
import SwiftyJSON

class SearchVC: UIViewController {

    @IBOutlet weak var tblSearch: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
    
    
    var arrAddressHotel = JSON().arrayValue
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        //        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: headerView.frame.width, height:50), byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: 25, height: 25.0))
        //        let mask = CAShapeLayer()
        //        mask.path = path.cgPath
        //        headerView.layer.mask = mask
        //        headerView.backgroundColor = .red
        
        
        //        headerView.layer.cornerRadius = 40
        //        headerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        
        
        //        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: btnHeder.frame.width, height:btnHeder.frame.height*2), byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: btnHeder.frame.height*2, height: btnHeder.frame.height*2))
        //        let mask = CAShapeLayer()
        //        mask.path = path.cgPath
        //        btnHeder.layer.mask = mask
        
        //   }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
        if let userDetails = Preference.shared.getUserLocationDetails(){
            let dict = ["address":"All Hotels in \(userDetails["placeName"].stringValue)",
                        "city_name":userDetails["placeName"].stringValue]
            
            self.arrAddressHotel = [JSON(dict)]
        }
        
       
        tblSearch.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
    }
}


extension SearchVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrAddressHotel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.lblHotelName.text = self.arrAddressHotel[indexPath.row]["address"].stringValue
        cell.lblLocation.text = self.arrAddressHotel[indexPath.row]["city_name"].stringValue + " , " + self.arrAddressHotel[indexPath.row]["state_name"].stringValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        let vc = SearchDetailVC.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 10, y: 8, width: 320, height: 20)
        myLabel.font = UIFont(name: "SFProText-Bold", size: 18)
        myLabel.text = "TOP RESULTS"

        let headerView = UIView()
        headerView.addSubview(myLabel)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
}


extension SearchVC{
    func searchHotelNew(searchText:String){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? "",
                     "search_text":searchText]

        HttpUtility.shared.post(requestUrl:AppUrl.searchHotelNew, param: param) { result in
            print(result)
            if result.count>0{
                self.arrAddressHotel = result[0]["address_hotel"].arrayValue
                self.tblSearch.reloadData()

            }
           
        }
        
    }



}


extension SearchVC:UITextFieldDelegate{
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count ?? 0>2{
            searchHotelNew(searchText: textField.text ?? "")
        }else{
            if let userDetails = Preference.shared.getUserLocationDetails(){
                let dict = ["address":"All Hotels in \(userDetails["placeName"].stringValue)",
                            "city_name":userDetails["placeName"].stringValue]
                
                self.arrAddressHotel = [JSON(dict)]
            }
            self.tblSearch.reloadData()
        }
        
        if self.arrAddressHotel.count>0{
            self.tblSearch.isHidden = false
        }else{
            self.tblSearch.isHidden = true
        }
    }
}

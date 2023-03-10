//
//  FavoriteVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 30/01/23.
//

import UIKit
import SwiftyJSON

class FavoriteVC: UIViewController {
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var tblFavorite: UITableView!
    var arrFavrite = JSON().arrayValue
    override func viewDidLoad() {
        super.viewDidLoad()

        tblFavorite.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        
        if let userData = Preference.shared.getUserDetails(){
            loginView.isHidden = true
            getFavorite()
        }else{
            loginView.isHidden = false
        }
    }

}

extension FavoriteVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell") as! FavoriteTableViewCell
        return cell
    }
}


extension FavoriteVC{
    func getFavorite(){
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

        HttpUtility.shared.post(requestUrl: AppUrl.favoriteDetailsAll, param: param) { result in
            print(result)
            if result.count>0{
                self.arrFavrite = result[0]["favorite_list"].arrayValue
                if self.arrFavrite.count>0{
                    self.tblFavorite.isHidden = false
                }else{
                    self.tblFavorite.isHidden = true
                }
                self.tblFavorite.reloadData()

            }
           
        }
        
    }
    
    func removeFavorite(){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? "",
                     "HotelID":"",
                     "hotel_id":"",
                     "show_flag":"d"]

        HttpUtility.shared.post(requestUrl: AppUrl.addRemoveFavoriteHotel, param: param) { result in
            print(result)
           
           
        }
        
    }
}

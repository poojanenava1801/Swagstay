//
//  ReviewRatingVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 05/03/23.
//

import UIKit
import SwiftyJSON

class ReviewRatingVC: UIViewController {

    @IBOutlet weak var tblReview: UITableView!
    var arrReview = JSON().arrayValue
    var hotelid = ""
    var hotelID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblReview.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
        reviewRatingHotel()
    }
    

}

extension ReviewRatingVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrReview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell
        cell.lblName.text = "\(self.arrReview[indexPath.row]["customer_name"].stringValue )"
        cell.lblReviewDescription.text = "\(self.arrReview[indexPath.row]["comment_msg"].stringValue )"
        cell.btnRating.setTitle("\(self.arrReview[indexPath.row]["rating_total"].stringValue )", for: .normal)

        return cell
    }
    
    
}

extension ReviewRatingVC{
    func reviewRatingHotel(){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? "",
                     "hotel_id":hotelid,
                     "latitude":"",
                     "longitude":"",
                     "HotelID":hotelID,
                     "flag":"1"]

        HttpUtility.shared.post(requestUrl: AppUrl.reviewratingHotel, param: param) { result in
            print(result)
            if result.count>0{
                self.arrReview = result[0]["review_rating_list"].arrayValue
                self.tblReview.reloadData()
            }
           
           
        }
        
    }
    
}

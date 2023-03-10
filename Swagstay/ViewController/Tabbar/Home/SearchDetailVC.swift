//
//  SearchDetailVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 08/03/23.
//

import UIKit
import SwiftyJSON

class SearchDetailVC: UIViewController {

    @IBOutlet weak var viewFilter: UIView!
    @IBOutlet weak var collViewRecommend: UICollectionView!
    
    @IBOutlet weak var tblAllHotelHeight: NSLayoutConstraint!
    @IBOutlet weak var tblAllHotel: UITableView!
    var arrRecommendedList = JSON().arrayValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewFilter.roundCorners([.topLeft,.bottomLeft], radius: 20)
        collViewRecommend.register(UINib(nibName: "HotelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HotelCollectionViewCell")
        
        tblAllHotel.register(UINib(nibName: "AllHotelsTableViewCell", bundle: nil), forCellReuseIdentifier: "AllHotelsTableViewCell")
        
        self.tblAllHotelHeight?.constant = CGFloat.greatestFiniteMagnitude
        self.tblAllHotel.reloadData()
        self.tblAllHotel.layoutIfNeeded()
        self.tblAllHotelHeight?.constant = self.tblAllHotel.contentSize.height
    }
    

    

}

extension SearchDetailVC:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2//self.arrRecommendedList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotelCollectionViewCell", for: indexPath) as! HotelCollectionViewCell
        cell.viewRatingUpper.isHidden = true
        
//        cell.lblRatingBelow.text = self.arrRecommendedList[indexPath.row]["total_rating"].stringValue
//        cell.lblHotelName.text = self.arrRecommendedList[indexPath.row]["hotel_name"].stringValue
//        cell.lblHotelAddress.text = self.arrRecommendedList[indexPath.row]["small_description"].stringValue
//        cell.lblLowestPrice.text = "₹ \(self.arrRecommendedList[indexPath.row]["lowest_price"].stringValue)"
//        cell.lblDiscountPrice.text = "₹ \(self.arrRecommendedList[indexPath.row]["discount_price"].stringValue)"
//
//
//        if let imgUrl = URL(string: AppUrl.hotelImageUrl+self.arrRecommendedList[indexPath.row]["image_name"].stringValue){
//            cell.imgHotel.sd_setImage(with: imgUrl)
//        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = HomeDetailViewController.instantiate(storyboard: .main)
       // vc.dictHotel = self.arrRecommendedList[indexPath.row].dictionaryValue
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension SearchDetailVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllHotelsTableViewCell") as! AllHotelsTableViewCell
        let attributedString = NSMutableAttributedString(string: "₹ 1234", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 1, length: attributedString.length-2))
        
        cell.lblCrossPrice.attributedText = attributedString
        return cell
    }
}


extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(1,attributeString.length))
        return attributeString
    }
}

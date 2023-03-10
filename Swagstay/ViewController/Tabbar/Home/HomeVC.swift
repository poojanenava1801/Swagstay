//
//  HomeVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 29/01/23.
//

import UIKit
import CoreLocation
import SwiftyJSON
import SDWebImage


class HomeVC: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btnWallet: UIButton!
    @IBOutlet weak var lblReferEarnDescription: UILabel!
    @IBOutlet weak var lblReferEarn: UILabel!
    @IBOutlet weak var viewReferEarnView: UIView!
    @IBOutlet weak var collViewLocation: UICollectionView!
    @IBOutlet weak var collViewRecommendedHotel: UICollectionView!
    @IBOutlet weak var CollViewTodayDeals: UICollectionView!
    @IBOutlet weak var collViewFeatured: UICollectionView!
    @IBOutlet weak var collViewBlogs: UICollectionView!
    
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var viewReferWallet: UIView!
    @IBOutlet weak var viewHeightReferWallet: NSLayoutConstraint!
    var locManager = CLLocationManager()
    var currentLocationLat = ""
    var currentLocationLong = ""
    
    var arrHotelCityList = JSON().arrayValue
    var arrRecommendedList = JSON().arrayValue
    var arrTodayDealsList = JSON().arrayValue
    var arrFeaturedList = JSON().arrayValue
    var arrBlogList = JSON().arrayValue
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var lblUnderCons: UILabel!
    
    @IBOutlet weak var imgUndercon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        //headerView.addShadowToView()
        
        //addShadow(offset: CGSize.init(width: 0, height: 1), color: UIColor.lightGray, radius: 2.0, opacity: 0.4)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateSideMenu(_:)), name: NSNotification.Name(rawValue:"sidemenu"), object: nil)
        collViewLocation.register(UINib(nibName: "LocationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LocationCollectionViewCell")
        collViewRecommendedHotel.register(UINib(nibName: "HotelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HotelCollectionViewCell")
        CollViewTodayDeals.register(UINib(nibName: "TodayDealsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TodayDealsCollectionViewCell")
        collViewFeatured.register(UINib(nibName: "HotelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HotelCollectionViewCell")
        collViewBlogs.register(UINib(nibName: "BlogsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BlogsCollectionViewCell")
        setupShareButton()
        locManager.requestWhenInUseAuthorization()
        
        viewReferEarnView.roundCorners([.topLeft,.bottomRight,.topRight], radius: 60.0)
        
        btnSearch.addTap {
            let vc = SearchVC.instantiate(storyboard: .main)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        if
           CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocationLat = "\(locManager.location?.coordinate.latitude ?? 0.00)"
            currentLocationLong = "\(locManager.location?.coordinate.longitude ?? 0.00)"
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: locManager.location?.coordinate.latitude ?? 0.00, longitude:  locManager.location?.coordinate.longitude ?? 0.00) // <- New York

            geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in

                placemarks?.forEach { (placemark) in

                    if let city = placemark.locality {
                        print(city)
                        let dictLocation = ["longitude":self.currentLocationLong,
                                            "latitude":self.currentLocationLat,
                                            "placeName":city]
                        Preference.shared.setUserLocationDetails(data: JSON(dictLocation))
                    } // Prints "New York"
                }
            })
            
            
            
            getDashboardData()
        }else{
            getDashboardData()
        }
        
        
    }
  
    
    @IBAction func btnReferEarnTapped(_ sender: UIButton) {
        let vc = ReferAndEarnVC.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnWalletTapped(_ sender: UIButton) {
        let vc = WalletVC.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}

extension HomeVC:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collViewLocation{
            return self.arrHotelCityList.count
        }else if collectionView == collViewRecommendedHotel{
            return self.arrRecommendedList.count
        }else if collectionView == CollViewTodayDeals{
            return self.arrTodayDealsList.count
        }else if collectionView == collViewFeatured{
            return self.arrFeaturedList.count
        }else{
            return self.arrBlogList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collViewLocation{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LocationCollectionViewCell", for: indexPath) as! LocationCollectionViewCell
            if indexPath.row == 0{
                cell.imgCity.image = UIImage(named: "nearby")
                cell.imgCity.backgroundColor = .clear
            }else{
                if let imgUrl = URL(string: AppUrl.cityImageUrl+self.arrHotelCityList[indexPath.row]["image_name"].stringValue){
                    cell.imgCity.sd_setImage(with: imgUrl)
                    cell.imgCity.backgroundColor = .clear
                }
            }
            
            cell.lblCityName.text = self.arrHotelCityList[indexPath.row]["city_name"].stringValue
            return cell
        }else if collectionView == collViewRecommendedHotel{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotelCollectionViewCell", for: indexPath) as! HotelCollectionViewCell
            cell.viewRatingUpper.isHidden = true
            
            cell.lblRatingBelow.text = self.arrRecommendedList[indexPath.row]["total_rating"].stringValue
            cell.lblHotelName.text = self.arrRecommendedList[indexPath.row]["hotel_name"].stringValue
            cell.lblHotelAddress.text = self.arrRecommendedList[indexPath.row]["small_description"].stringValue
            cell.lblLowestPrice.text = "₹ \(self.arrRecommendedList[indexPath.row]["lowest_price"].stringValue)"
            
            let attributedString = NSMutableAttributedString(string: "₹ \(self.arrRecommendedList[indexPath.row]["lowest_price"].stringValue)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.red])
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSRange(location: 1, length: attributedString.length-2))
            
            cell.lblLowestPrice.attributedText = attributedString
            
            
            cell.lblDiscountPrice.text = "₹ \(self.arrRecommendedList[indexPath.row]["discount_price"].stringValue)"


            if let imgUrl = URL(string: AppUrl.hotelImageUrl+self.arrRecommendedList[indexPath.row]["image_name"].stringValue){
                cell.imgHotel.sd_setImage(with: imgUrl)
            }
            
            
            return cell
        }else if collectionView == CollViewTodayDeals{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayDealsCollectionViewCell", for: indexPath) as! TodayDealsCollectionViewCell
            cell.lblRating.text = self.arrTodayDealsList[indexPath.row]["total_rating"].stringValue
            cell.lblHotelName.text = self.arrTodayDealsList[indexPath.row]["hotel_name"].stringValue
            cell.lblHotelAddress.text = self.arrTodayDealsList[indexPath.row]["small_description"].stringValue
            cell.lblLowestPrice.text = "₹ \(self.arrTodayDealsList[indexPath.row]["lowest_price"].stringValue)"
            cell.lblDiscountPrice.text = "₹ \(self.arrTodayDealsList[indexPath.row]["discount_price"].stringValue)"
            cell.lblDiscountPercent.text = "\(self.arrTodayDealsList[indexPath.row]["discount"].stringValue)%"

            if let imgUrl = URL(string: AppUrl.hotelImageUrl+self.arrTodayDealsList[indexPath.row]["image_name"].stringValue){
                cell.imgHotel.sd_setImage(with: imgUrl)
            }
            return cell
        }else if collectionView == collViewFeatured{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotelCollectionViewCell", for: indexPath) as! HotelCollectionViewCell
            cell.viewRatingBelow.isHidden = true
            cell.lblRatingUper.text = self.arrFeaturedList[indexPath.row]["total_rating"].stringValue
            cell.lblHotelName.text = self.arrFeaturedList[indexPath.row]["hotel_name"].stringValue
            cell.lblHotelAddress.text = self.arrFeaturedList[indexPath.row]["small_description"].stringValue
            cell.lblLowestPrice.text = "₹ \(self.arrFeaturedList[indexPath.row]["lowest_price"].stringValue)"
            cell.lblDiscountPrice.text = "₹ \(self.arrFeaturedList[indexPath.row]["discount_price"].stringValue)"


            if let imgUrl = URL(string: AppUrl.hotelImageUrl+self.arrFeaturedList[indexPath.row]["image_name"].stringValue){
                cell.imgHotel.sd_setImage(with: imgUrl)
            }
            
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BlogsCollectionViewCell", for: indexPath) as! BlogsCollectionViewCell
            if let imgUrl = URL(string:self.arrBlogList[indexPath.row]["banner_image"].stringValue){
                cell.imgHotel.sd_setImage(with: imgUrl)
            }
            cell.lblTitle.text = self.arrBlogList[indexPath.row]["title_name"].stringValue
            cell.lblTagLine.text = self.arrBlogList[indexPath.row]["tag_line"].stringValue
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collViewLocation{
            currentLocationLat = self.arrHotelCityList[indexPath.row]["city_lat"].stringValue
            currentLocationLong = self.arrHotelCityList[indexPath.row]["city_long"].stringValue
            getDashboardData()
        }else if collectionView == collViewRecommendedHotel{
            let vc = HomeDetailViewController.instantiate(storyboard: .main)
            vc.dictHotel = self.arrRecommendedList[indexPath.row].dictionaryValue
            self.navigationController?.pushViewController(vc, animated: true)
        }else if collectionView == CollViewTodayDeals{
            let vc = HomeDetailViewController.instantiate(storyboard: .main)
            vc.dictHotel = self.arrTodayDealsList[indexPath.row].dictionaryValue
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else if collectionView == collViewFeatured{
            let vc = HomeDetailViewController.instantiate(storyboard: .main)
            vc.dictHotel = self.arrFeaturedList[indexPath.row].dictionaryValue
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = BlogDescriptionVC.instantiate(storyboard: .main)
            vc.dictBolgs = self.arrBlogList[indexPath.row].dictionaryValue
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
}

extension HomeVC{
    func getDashboardData(){
        
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "refer_code":"",
                     "latitude":currentLocationLat,
                     "longitude":currentLocationLong,
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? ""]
        
        HttpUtility.shared.post(requestUrl:AppUrl.frontDashboard, param: param) { result in
            print(result)
            if result.count>0{
                self.lblReferEarnDescription.text = result[0]["refer_text"].stringValue
                
                if result[0]["wallet_amount"].stringValue == ""{
                    self.viewHeightReferWallet.constant = 0
                    self.viewReferWallet.isHidden = true
                }else{
                    self.viewHeightReferWallet.constant = 320
                    self.viewReferWallet.isHidden = false
                }
                
                self.btnWallet.setTitle(result[0]["wallet_amount"].stringValue, for: .normal)
                var arrTempCity = JSON().arrayValue

                let nearByDict = ["city_id": "0",
                                  "image_name": "",
                                  "city_lat": self.currentLocationLat,
                                  "city_long": self.currentLocationLong,
                                  "city_name": "Near by"] as! [String:String]
                
                arrTempCity.append(JSON(nearByDict))
                
                self.arrHotelCityList = arrTempCity+result[0]["hotel_citylist"].arrayValue
                self.arrRecommendedList = result[0]["recommend_list"].arrayValue
                self.arrTodayDealsList = result[0]["todaydeal_list"].arrayValue
                self.arrFeaturedList = result[0]["featured_list"].arrayValue
                if let dataFromString = result[0]["blog_list"].stringValue.data(using: String.Encoding.utf8, allowLossyConversion: false) {
                    do{
                        let json = try JSON(data: dataFromString)
                        print(json)
                        self.arrBlogList = json.arrayValue
                    }catch{
                       print("Error")
                    }
                    
                }
                
                
                
                DispatchQueue.main.async {
                    self.collViewLocation.reloadData()
                    self.collViewRecommendedHotel.reloadData()
                    self.CollViewTodayDeals.reloadData()
                    self.collViewFeatured.reloadData()
                    self.collViewBlogs.reloadData()
                }
                
                
                
                if self.currentLocationLat == ""{
                    self.currentLocationLat = result[0]["hotel_citylist"][0]["city_lat"].stringValue
                    self.currentLocationLong = result[0]["hotel_citylist"][0]["city_long"].stringValue
                    self.getDashboardData()
                }
                
                
                self.imgUndercon.sd_setImage(with: URL(string: "\(result[0]["under_construction_link"].stringValue)\(result[0]["under_construction_image"].stringValue)"), placeholderImage: UIImage(named: "logo_small"))
                if result[0]["under_construction_status"].stringValue == "0" || result[0]["under_construction_status"].stringValue == ""{
                    self.scrollView.isHidden = false
                }else{
                    self.scrollView.isHidden = true
                }
            }

        }
        
    }
    
        func searchHotelAll(){
            
            let param = ["cd_id":"14",
                         "key_secret":"swagstayhotel_key@2022",
                         "web_app":"IOS",
                         "token":Preference.shared.getUserFCMToken() ?? "",
                         "longitude":"",
                         "latitude":"",
                         "flag":"1",
                         "hotel_id":"0",
                         "checkin_date":"",
                         "checkout_date":"",
                         "from_range":"",
                         "to_range":"",
                         "other_search":"",
                         "facilities":"",
                         "total_rating":""]

            HttpUtility.shared.post(requestUrl:AppUrl.searchHotelAll, param: param) { result in
                print(result)
               
               
            }
            
        }
    

    
}



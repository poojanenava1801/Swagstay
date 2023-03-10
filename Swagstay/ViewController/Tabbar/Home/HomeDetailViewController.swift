//
//  HomeDetailViewController.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 22/02/23.
//

import UIKit
import FSPagerView
import SwiftyJSON
import Cosmos
import SDWebImage
import Razorpay


class HomeDetailViewController: UIViewController {
    let razorpayKey = "rzp_live_YREZ9chVRekTNL"
    var razorpayObj : RazorpayCheckout? = nil

    @IBOutlet weak var lblTotalPayATHotel: UILabel!
    @IBOutlet weak var collViewPhotos: UICollectionView!{
        didSet{
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical //.horizontal
            layout.itemSize = CGSize(width: (collViewPhotos.frame.width/3)-10, height: 80)
            layout.sectionInset = UIEdgeInsets(top: 5, left: 2.5, bottom: 5, right: 2.5)
            layout.minimumLineSpacing = 10.0
            layout.minimumInteritemSpacing = 5.0
            collViewPhotos.setCollectionViewLayout(layout, animated: true)
            collViewPhotos.reloadData()
        }
    }
    
    @IBOutlet weak var lblUseAmount: UILabel!
    @IBOutlet weak var lblUseWalletAmount: UILabel!
    @IBOutlet weak var viewCoupleFriendly: UIView!
    @IBOutlet weak var collViewCategory: UICollectionView!
    @IBOutlet weak var collViewPhotosHeight: NSLayoutConstraint!
    @IBOutlet weak var CollViewFacilities: UICollectionView!
    @IBOutlet weak var viewPerNight: UIView!
    
    @IBOutlet weak var lblSelectedPromoCode: UILabel!
    
    @IBOutlet weak var tblNearBy: UITableView!
    @IBOutlet weak var tblComments: UITableView!

    
    @IBOutlet weak var btnHotelShare: UIButton!
    @IBOutlet weak var btnTransport: UIButton!
    @IBOutlet weak var lblBelowTransport: UILabel!
    @IBOutlet weak var btnRestaurant: UIButton!
    @IBOutlet weak var lblBelowRestaurant: UILabel!
    @IBOutlet weak var btnHospital: UIButton!
    @IBOutlet weak var lblBelowHospital: UILabel!
    @IBOutlet weak var btnOther: UIButton!
    @IBOutlet weak var lblBelowOther: UILabel!
    
    @IBOutlet weak var viewLeftWithCorner: UIView!
    @IBOutlet weak var viewRightWithCorner: UIView!
    
    
    @IBOutlet weak var btnPayNowToBook: UIButton!
    @IBOutlet weak var btnPayAtHotel: UIButton!
    
    @IBOutlet weak var btnShowMoreReview: UIButton!
    @IBOutlet weak var viewComments: UIView!
    @IBOutlet weak var imgHotel: UIImageView!
    @IBOutlet weak var lblHotelName: UILabel!
    @IBOutlet weak var lblHotelAddress: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblHotelNightPrice: UILabel!
    @IBOutlet weak var lblLocationAddress: UILabel!
    @IBOutlet weak var lblCheckInDate: UILabel!
    @IBOutlet weak var lblCheckOutDate: UILabel!
    @IBOutlet weak var lblRoomGuestTotal: UILabel!
    @IBOutlet weak var lblAboutUs: UILabel!
    @IBOutlet weak var btnRead: UIButton!
    @IBOutlet weak var lblPriceToPay: UILabel!
    @IBOutlet weak var lblRoomNightGuest: UILabel!
    @IBOutlet weak var lblNightGuestPrice: UILabel!
    @IBOutlet weak var lblTotalPayble: UILabel!
    
    @IBOutlet weak var lblHtmlText: UILabel!
    
    
    
    
    
    
    
    @IBOutlet weak var myPicker: MyDatePicker!
    var arrSel = JSON().arrayValue
    var dictHotel = JSON().dictionaryValue
    var arrHotelCategory = JSON().arrayValue
    var arrFacilityList = JSON().arrayValue
    var arrHotelImageList = JSON().arrayValue
    var arrReview = JSON().arrayValue
    var hotelImageLink = ""
    var hotelFacilityImageLink = ""
    var hotelCategoryImageLink = ""
    var selectedIndexCategory = 0
    var isCheckInTap = false
    var shareUrl = ""
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        viewPerNight.roundCorners([.topLeft,.bottomLeft], radius: 20)
        CollViewFacilities.register(UINib(nibName: "FacilitiesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FacilitiesCollectionViewCell")
        collViewPhotos.register(UINib(nibName: "PhotosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotosCollectionViewCell")
        collViewCategory.register(UINib(nibName: "CategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        tblComments.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentTableViewCell")
        tblNearBy.register(UINib(nibName: "NearBySubTableViewCell", bundle: nil), forCellReuseIdentifier: "NearBySubTableViewCell")
        
        self.btnTransport.addTap {
            self.count = 0
            self.btnTransport.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
            self.lblBelowTransport.isHidden = false
            self.btnHospital.setTitleColor(.darkGray, for: .normal)
            self.lblBelowHospital.isHidden = true
            self.btnRestaurant.setTitleColor(.darkGray, for: .normal)
            self.lblBelowRestaurant.isHidden = true
            self.btnOther.setTitleColor(.darkGray, for: .normal)
            self.lblBelowOther.isHidden = true
            //self.pagerViewBanner.scrollToItem(at: 0, animated: true)
            self.NearByData(hotelid: self.dictHotel["hotel_id"]?.stringValue ?? "", hotelID: self.dictHotel["HotelID"]?.stringValue ?? "", nsId: "1")
        }
        
        self.btnHospital.addTap {
            self.count = 2
            self.btnHospital.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
            self.lblBelowHospital.isHidden = false
            self.btnTransport.setTitleColor(.darkGray, for: .normal)
            self.lblBelowTransport.isHidden = true
            self.btnRestaurant.setTitleColor(.darkGray, for: .normal)
            self.lblBelowRestaurant.isHidden = true
            self.btnOther.setTitleColor(.darkGray, for: .normal)
            self.lblBelowOther.isHidden = true
            //self.pagerViewBanner.scrollToItem(at: 2, animated: true)
            self.NearByData(hotelid: self.dictHotel["hotel_id"]?.stringValue ?? "", hotelID: self.dictHotel["HotelID"]?.stringValue ?? "", nsId: "3")
        }
        
        self.btnRestaurant.addTap {
            self.count = 1
            self.btnRestaurant.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
            self.lblBelowRestaurant.isHidden = false
            self.btnHospital.setTitleColor(.darkGray, for: .normal)
            self.lblBelowHospital.isHidden = true
            self.btnTransport.setTitleColor(.darkGray, for: .normal)
            self.lblBelowTransport.isHidden = true
            self.btnOther.setTitleColor(.darkGray, for: .normal)
            self.lblBelowOther.isHidden = true
            //self.pagerViewBanner.scrollToItem(at:1, animated: true)
            self.NearByData(hotelid: self.dictHotel["hotel_id"]?.stringValue ?? "", hotelID: self.dictHotel["HotelID"]?.stringValue ?? "", nsId: "2")
        }
        
        self.btnOther.addTap {
            self.count = 3
            self.btnOther.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
            self.lblBelowOther.isHidden = false
            self.btnHospital.setTitleColor(.darkGray, for: .normal)
            self.lblBelowHospital.isHidden = true
            self.btnRestaurant.setTitleColor(.darkGray, for: .normal)
            self.lblBelowRestaurant.isHidden = true
            self.btnTransport.setTitleColor(.darkGray, for: .normal)
            self.lblBelowTransport.isHidden = true
           // self.pagerViewBanner.scrollToItem(at: 3, animated: true)
            self.NearByData(hotelid: self.dictHotel["hotel_id"]?.stringValue ?? "", hotelID: self.dictHotel["HotelID"]?.stringValue ?? "", nsId: "4")
        }
        
        btnHotelShare.addTap {
            
            // Setting description
                let firstActivityItem = "Check Out this Hotel In Swagstay"

                // Setting url
            let secondActivityItem : URL = URL(string:self.shareUrl)!
                
                // If you want to use an image
                let image : UIImage = UIImage(named: "logo_small")!
                let activityViewController : UIActivityViewController = UIActivityViewController(
                    activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)
                
                // This lines is for the popover you need to show in iPad
            activityViewController.popoverPresentationController?.sourceView = (self.btnHotelShare!)
                
                // This line remove the arrow of the popover to show in iPad
                activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
                activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
                
                // Pre-configuring activity items
                activityViewController.activityItemsConfiguration = [
                UIActivity.ActivityType.message
                ] as? UIActivityItemsConfigurationReading
                
                // Anything you want to exclude
                activityViewController.excludedActivityTypes = [
                    UIActivity.ActivityType.postToWeibo,
                    UIActivity.ActivityType.print,
                    UIActivity.ActivityType.assignToContact,
                    UIActivity.ActivityType.saveToCameraRoll,
                    UIActivity.ActivityType.addToReadingList,
                    UIActivity.ActivityType.postToFlickr,
                    UIActivity.ActivityType.postToVimeo,
                    UIActivity.ActivityType.postToTencentWeibo,
                    UIActivity.ActivityType.postToFacebook
                ]
                
                activityViewController.isModalInPresentation = true
                self.present(activityViewController, animated: true, completion: nil)
        }
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        let resultString = dateFormatter.string(from: Date())
        
        let resultString1 = dateFormatter.string(from: Date().add(.day, value: 1) ?? Date())
        print(resultString)
        
            self.lblCheckInDate.text = resultString
            self.lblCheckOutDate.text = resultString1
        
        
        myPicker.dismissClosure = { [weak self] in
                    guard let self = self else {
                        return
                    }
                    self.myPicker.isHidden = true
                }
                myPicker.changeClosure = { [weak self] val in
                    guard let self = self else {
                        return
                    }
                    print(val)
                    
                    if val>=Date(){
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                        let date = dateFormatter.date(from: "\(val)")
                        dateFormatter.dateFormat = "dd MMM"
                        let resultString = dateFormatter.string(from: date!)
                        print(resultString)
                        
                        if self.isCheckInTap{
                            self.lblCheckInDate.text = resultString
                            self.lblCheckOutDate.text = dateFormatter.string(from: date!.add(.day, value: 1) ?? Date())
                        }else{
                            self.lblCheckOutDate.text = resultString
                        }
                    }else{
                        
                    }
                    
                    
                    
                    
                    self.myPicker.isHidden = true
                    // do something with the selected date
                }

        
        lblHotelName.text = dictHotel["hotel_name"]?.stringValue ?? ""
        lblHotelAddress.text = dictHotel["address"]?.stringValue ?? ""
        viewRating.rating = dictHotel["total_rating"]?.doubleValue ?? 0.00
        lblRating.text = dictHotel["total_rating"]?.stringValue ?? ""
        lblLocationAddress.text = dictHotel["address"]?.stringValue ?? ""
        
        btnRead.addTap {
            self.btnRead.isSelected = !self.btnRead.isSelected
            if self.btnRead.isSelected{
                self.lblAboutUs.numberOfLines = 0
                self.btnRead.setTitle("Read Less", for: .normal)
                self.btnRead.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
            }else{
                self.lblAboutUs.numberOfLines = 2
                self.btnRead.setTitle("Read More", for: .normal)
                self.btnRead.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
            }
            
           
        }
        
        btnShowMoreReview.addTap {
            let vc = ReviewRatingVC.instantiate(storyboard: .main)
            vc.hotelid = self.dictHotel["hotel_id"]?.stringValue ?? ""
            vc.hotelID = self.dictHotel["HotelID"]?.stringValue ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        btnPayNowToBook.addTap {
            self.openRazorpayCheckout()
        }
        
        btnPayAtHotel.addTap {
            print("btnPayAtHoteltap")
        }
        
        
        
        if self.dictHotel["couple_friendly"]?.stringValue == "1"{
            self.viewCoupleFriendly.isHidden = false
        }else{
            self.viewCoupleFriendly.isHidden = true
        }
        
        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(leftSwiped))
            leftGesture.direction = .left
            tblNearBy.addGestureRecognizer(leftGesture)

            let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(rightSwiped))
            rightGesture.direction = .right
        tblNearBy.addGestureRecognizer(rightGesture)
        
    }
    
    @objc func leftSwiped() {
        print("LEFT")
        count = count+1
        if count == 0{
            self.btnTransport.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
            self.lblBelowTransport.isHidden = false
            self.btnHospital.setTitleColor(.darkGray, for: .normal)
            self.lblBelowHospital.isHidden = true
            self.btnRestaurant.setTitleColor(.darkGray, for: .normal)
            self.lblBelowRestaurant.isHidden = true
            self.btnOther.setTitleColor(.darkGray, for: .normal)
            self.lblBelowOther.isHidden = true
            self.NearByData(hotelid: self.dictHotel["hotel_id"]?.stringValue ?? "", hotelID: self.dictHotel["HotelID"]?.stringValue ?? "", nsId: "1")
        }else if count == 1{
            self.btnRestaurant.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
            self.lblBelowRestaurant.isHidden = false
            self.btnHospital.setTitleColor(.darkGray, for: .normal)
            self.lblBelowHospital.isHidden = true
            self.btnTransport.setTitleColor(.darkGray, for: .normal)
            self.lblBelowTransport.isHidden = true
            self.btnOther.setTitleColor(.darkGray, for: .normal)
            self.lblBelowOther.isHidden = true
            self.NearByData(hotelid: self.dictHotel["hotel_id"]?.stringValue ?? "", hotelID: self.dictHotel["HotelID"]?.stringValue ?? "", nsId: "2")
        }else if count == 2{
            self.btnHospital.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
            self.lblBelowHospital.isHidden = false
            self.btnTransport.setTitleColor(.darkGray, for: .normal)
            self.lblBelowTransport.isHidden = true
            self.btnRestaurant.setTitleColor(.darkGray, for: .normal)
            self.lblBelowRestaurant.isHidden = true
            self.btnOther.setTitleColor(.darkGray, for: .normal)
            self.lblBelowOther.isHidden = true
            self.NearByData(hotelid: self.dictHotel["hotel_id"]?.stringValue ?? "", hotelID: self.dictHotel["HotelID"]?.stringValue ?? "", nsId: "3")
        }else{
            self.btnOther.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
            self.lblBelowOther.isHidden = false
            self.btnHospital.setTitleColor(.darkGray, for: .normal)
            self.lblBelowHospital.isHidden = true
            self.btnRestaurant.setTitleColor(.darkGray, for: .normal)
            self.lblBelowRestaurant.isHidden = true
            self.btnTransport.setTitleColor(.darkGray, for: .normal)
            self.lblBelowTransport.isHidden = true
            self.NearByData(hotelid: self.dictHotel["hotel_id"]?.stringValue ?? "", hotelID: self.dictHotel["HotelID"]?.stringValue ?? "", nsId: "4")
            count = -1
        }
        
       
    }
    

    @objc func rightSwiped() {
        print("Right")
        count = count-1
    
        if count == 0{
            self.btnTransport.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
            self.lblBelowTransport.isHidden = false
            self.btnHospital.setTitleColor(.darkGray, for: .normal)
            self.lblBelowHospital.isHidden = true
            self.btnRestaurant.setTitleColor(.darkGray, for: .normal)
            self.lblBelowRestaurant.isHidden = true
            self.btnOther.setTitleColor(.darkGray, for: .normal)
            self.lblBelowOther.isHidden = true
            self.NearByData(hotelid: self.dictHotel["hotel_id"]?.stringValue ?? "", hotelID: self.dictHotel["HotelID"]?.stringValue ?? "", nsId: "1")
        }else if count == 1{
            self.btnRestaurant.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
            self.lblBelowRestaurant.isHidden = false
            self.btnHospital.setTitleColor(.darkGray, for: .normal)
            self.lblBelowHospital.isHidden = true
            self.btnTransport.setTitleColor(.darkGray, for: .normal)
            self.lblBelowTransport.isHidden = true
            self.btnOther.setTitleColor(.darkGray, for: .normal)
            self.lblBelowOther.isHidden = true
            self.NearByData(hotelid: self.dictHotel["hotel_id"]?.stringValue ?? "", hotelID: self.dictHotel["HotelID"]?.stringValue ?? "", nsId: "2")
        }else if count == 2{
            self.btnHospital.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
            self.lblBelowHospital.isHidden = false
            self.btnTransport.setTitleColor(.darkGray, for: .normal)
            self.lblBelowTransport.isHidden = true
            self.btnRestaurant.setTitleColor(.darkGray, for: .normal)
            self.lblBelowRestaurant.isHidden = true
            self.btnOther.setTitleColor(.darkGray, for: .normal)
            self.lblBelowOther.isHidden = true
            self.NearByData(hotelid: self.dictHotel["hotel_id"]?.stringValue ?? "", hotelID: self.dictHotel["HotelID"]?.stringValue ?? "", nsId: "3")
        }else{
            self.btnOther.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
            self.lblBelowOther.isHidden = false
            self.btnHospital.setTitleColor(.darkGray, for: .normal)
            self.lblBelowHospital.isHidden = true
            self.btnRestaurant.setTitleColor(.darkGray, for: .normal)
            self.lblBelowRestaurant.isHidden = true
            self.btnTransport.setTitleColor(.darkGray, for: .normal)
            self.lblBelowTransport.isHidden = true
            self.NearByData(hotelid: self.dictHotel["hotel_id"]?.stringValue ?? "", hotelID: self.dictHotel["HotelID"]?.stringValue ?? "", nsId: "4")
            count = 3
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getHomeDetail(hotelid: dictHotel["hotel_id"]?.stringValue ?? "", hotelID: dictHotel["HotelID"]?.stringValue ?? "")
    }
    
    @IBAction func btnAddRoomTapped(_ sender: UIButton) {
        let vc = AddRoomVC.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnWalletCheckMarkTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }else{
            sender.setImage(UIImage(systemName: "square"), for: .normal)
        }
    }
    @IBAction func btnCheckOutDateTapped(_ sender: UIButton) {
        isCheckInTap = false
        myPicker.isHidden = false
    }
    @IBAction func btnCheckInDateTapped(_ sender: UIButton) {
        isCheckInTap = true
        myPicker.isHidden = false
    }
    @IBAction func mapTapped(_ sender: UIButton) {
        let lat = "22.7488857"
        let long = "75.8287023"
        
        if (UIApplication.shared.canOpenURL(NSURL(string:"comgooglemaps://")! as URL)) {
            UIApplication.shared.openURL(NSURL(string:"comgooglemaps://?saddr=&daddr=\(lat),\(long)&directionsmode=driving")! as URL)
            
        } else {
            print("Can't use comgooglemaps://")
        }
    }
    
    @IBAction func btnViewOfferTapped(_ sender: UIButton) {
        let vc = PromoCodeVC.instantiate(storyboard: .main)
        vc.hotelId = dictHotel["hotel_id"]?.stringValue ?? ""
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnPayAtHotelTapped(_ sender: UIButton) {
        let vc = ConfirmBookingVC.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeDetailViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == CollViewFacilities{
            return arrFacilityList.count
        }else if collectionView == collViewPhotos{
            return arrHotelImageList.count
        }else{
            return arrHotelCategory.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == CollViewFacilities{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FacilitiesCollectionViewCell", for: indexPath) as! FacilitiesCollectionViewCell
            let data = arrFacilityList[indexPath.row]
            
            if let imgUrl = URL(string: (self.hotelFacilityImageLink)+(data["animatie_code"].stringValue)){
                cell.imgFacilities.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "logo_placeholder"))
                
            }
            
            cell.lblFacilities.text = data["animatie_name"].stringValue
            return cell
        }else if collectionView == collViewPhotos{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
            let data = arrHotelImageList[indexPath.row]
            
            if let imgUrl = URL(string: (self.hotelImageLink)+(data["image_name"].stringValue)){
                cell.img.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "logo_placeholder"))
                
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for: indexPath) as! CategoryCollectionViewCell
            
            let data = arrHotelCategory[indexPath.row]
            
            if let imgUrl = URL(string: (self.hotelCategoryImageLink)+(data["room_images"].stringValue)){
                cell.imgHotel.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "logo_placeholder"))
                
            }
            cell.lblRoomType.text = data["category_name"].stringValue
            
            if selectedIndexCategory == indexPath.row{
                cell.btnSelected.backgroundColor = UIColor(hexString: "479D9A")
                cell.btnSelected.setTitleColor(.white, for: .normal)
            }else{
                cell.btnSelected.backgroundColor = .clear
                cell.btnSelected.setTitleColor(.black, for: .normal)
            }
            cell.btnSelected.addTap {
                self.selectedIndexCategory = indexPath.row
                self.collViewCategory.reloadData()
            }
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
    }
    
}


// FSPagerView Delegate Method
//extension HomeDetailViewController:FSPagerViewDataSource,FSPagerViewDelegate{
//
//    func numberOfItems(in pagerView: FSPagerView) -> Int {
//            return 4
//    }
//
//    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
//            let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "NearByCell", at: index) as! NearByCell
//        cell.tblNearBy.register(UINib(nibName: "NearBySubTableViewCell", bundle: nil), forCellReuseIdentifier: "NearBySubTableViewCell")
////            let userImage = arrHomeBanner1[index]
////            print(userImage)
////            cell.imBannerProduct.sd_setImage(with: URL(string:arrHomeBanner1[index].bannerImagesUrl ?? ""), placeholderImage: UIImage(named: "Title"))
//        cell.tblNearBy.dataSource = self
//
//        cell.tblNearBy.reloadData()
//            return cell
//
//    }
//
//    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
//        //self.pageControl.currentPage = targetIndex
//        if targetIndex == 0{
//            self.btnTransport.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
//            self.lblBelowTransport.isHidden = false
//            self.btnHospital.setTitleColor(.darkGray, for: .normal)
//            self.lblBelowHospital.isHidden = true
//            self.btnRestaurant.setTitleColor(.darkGray, for: .normal)
//            self.lblBelowRestaurant.isHidden = true
//            self.btnOther.setTitleColor(.darkGray, for: .normal)
//            self.lblBelowOther.isHidden = true
//           // self.pagerViewBanner.scrollToItem(at: 0, animated: true)
//        }else if targetIndex == 1{
//            self.btnRestaurant.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
//            self.lblBelowRestaurant.isHidden = false
//            self.btnHospital.setTitleColor(.darkGray, for: .normal)
//            self.lblBelowHospital.isHidden = true
//            self.btnTransport.setTitleColor(.darkGray, for: .normal)
//            self.lblBelowTransport.isHidden = true
//            self.btnOther.setTitleColor(.darkGray, for: .normal)
//            self.lblBelowOther.isHidden = true
//            //self.pagerViewBanner.scrollToItem(at:1, animated: true)
//        }else if targetIndex == 2{
//            self.btnHospital.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
//            self.lblBelowHospital.isHidden = false
//            self.btnTransport.setTitleColor(.darkGray, for: .normal)
//            self.lblBelowTransport.isHidden = true
//            self.btnRestaurant.setTitleColor(.darkGray, for: .normal)
//            self.lblBelowRestaurant.isHidden = true
//            self.btnOther.setTitleColor(.darkGray, for: .normal)
//            self.lblBelowOther.isHidden = true
//            //self.pagerViewBanner.scrollToItem(at: 2, animated: true)
//        }else{
//            self.btnOther.setTitleColor(UIColor(hexString: "479D9A"), for: .normal)
//            self.lblBelowOther.isHidden = false
//            self.btnHospital.setTitleColor(.darkGray, for: .normal)
//            self.lblBelowHospital.isHidden = true
//            self.btnRestaurant.setTitleColor(.darkGray, for: .normal)
//            self.lblBelowRestaurant.isHidden = true
//            self.btnTransport.setTitleColor(.darkGray, for: .normal)
//            self.lblBelowTransport.isHidden = true
//            //self.pagerViewBanner.scrollToItem(at: 3, animated: true)
//        }
//    }
//}

extension HomeDetailViewController{
    func getHomeDetail(hotelid:String,hotelID:String){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        
        var referCode = ""
        if let user = Preference.shared.getUserDetails(){
            referCode = "\(user["reffer_code"].stringValue )"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "latitude":self.dictHotel["latitude"]?.stringValue ?? "",
                     "longitude":self.dictHotel["longitude"]?.stringValue ?? "",
                     "web_app":"IOS",
                     "refer_code":referCode,
                     "hotel_id":hotelid,
                     "HotelID":hotelID,
                     "token":Preference.shared.getUserFCMToken() ?? ""]
        
        HttpUtility.shared.post(requestUrl:AppUrl.hotelDetails, param: param as [String : Any]) { result in
            print(result)
            if result.count>0{
                self.arrHotelCategory = result[0]["hotel_category"].arrayValue
                self.arrFacilityList = result[0]["facility_list"].arrayValue
                self.arrHotelImageList = result[0]["hotelimages_list"].arrayValue
                self.arrReview = result[0]["review_rating_list"].arrayValue
                
                if self.arrReview.count>0{
                    self.viewComments.isHidden = false
                }else{
                    self.viewComments.isHidden = true
                }
                self.self.shareUrl = result[0]["url_click"].stringValue
                self.hotelImageLink = result[0]["hotel_image_link"].stringValue
                self.hotelFacilityImageLink = result[0]["facility_image_link"].stringValue
                self.hotelCategoryImageLink = result[0]["categry_image_link"].stringValue
                
                if let imgUrl = URL(string: (self.hotelImageLink)+(self.dictHotel["image_name"]?.stringValue ?? "")){
                    self.imgHotel.sd_setImage(with: imgUrl, placeholderImage: UIImage(named: "logo_placeholder"))
                    
                    self.lblHotelNightPrice.text = result[0]["rupees_icon"].stringValue + (self.dictHotel["discount_price"]?.stringValue ?? "")
                    
                    self.lblPriceToPay.text = result[0]["rupees_icon"].stringValue + (self.dictHotel["discount_price"]?.stringValue ?? "")
                    
                    self.lblTotalPayble.text = result[0]["rupees_icon"].stringValue + (self.dictHotel["discount_price"]?.stringValue ?? "")
                    
                    self.lblUseWalletAmount.text = "Use your wallet cash "+result[0]["rupees_icon"].stringValue+" "+(result[0]["wallet_amt"].stringValue )
                    
                    self.lblUseAmount.text = result[0]["rupees_icon"].stringValue+" "+(result[0]["wallet_amt"].stringValue )
                    self.lblNightGuestPrice.text = result[0]["rupees_icon"].stringValue + (self.dictHotel["discount_price"]?.stringValue ?? "")
                    self.lblTotalPayATHotel.text = result[0]["rupees_icon"].stringValue + (self.dictHotel["discount_price"]?.stringValue ?? "")
                    
                    self.lblHtmlText.attributedText = result[0]["cancellationpolicy"].stringValue.htmlToAttributedString
                    
                    
                    self.NearByData(hotelid: result[0]["hotel_details"][0]["hotel_id"].stringValue, hotelID: result[0]["hotel_details"][0]["HotelID"].stringValue, nsId: "1")
                    self.lblAboutUs.text = result[0]["hotel_details"][0]["about_us"].stringValue
                    self.collViewPhotos.reloadData()
                    self.collViewCategory.reloadData()
                    self.CollViewFacilities.reloadData()
                    self.tblComments.reloadData()
                }
            }
           
        }
        
    }
    
    
    func NearByData(hotelid:String,hotelID:String,nsId:String){
        var userId = ""
        if let userCdId = Preference.shared.getUserCdId(){
            userId = "\(userCdId)"
        }
        let param = ["cd_id":userId,
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? "",
                     "hotel_id":hotelid,
                     "HotelID":hotelID,
                     "ns_id":nsId]

        HttpUtility.shared.post(requestUrl: AppUrl.nearbyhotel, param: param) { result in
            print(result)
            if result.count>0{
                self.arrSel = result[0]["bidding_information"].arrayValue
                self.tblNearBy.reloadData()
            }
        }
    }
    
    
   
    
    func cancelBooking(){
        
        let param = ["cd_id":"14",
                     "key_secret":"swagstayhotel_key@2022",
                     "web_app":"IOS",
                     "token":Preference.shared.getUserFCMToken() ?? "",
                     "hotel_id":"",
                     "HotelID":"",
                     "booking_id":""]

        HttpUtility.shared.post(requestUrl: AppUrl.cancelBooking, param: param) { result in
            print(result)
           
           
        }
        
    }
    
    
    

    
    
}

extension HomeDetailViewController:SavedPromoCodeDelegate{
    func getApplyPromoCode(dict: SwiftyJSON.JSON) {
        lblSelectedPromoCode.text = "\(dict["coupon_name"].stringValue) is Applied"
        lblPriceToPay.text = "₹ \((self.dictHotel["discount_price"]?.intValue ?? 0) - (Int(dict["total_amount"].stringValue ) ?? 0))"
        
    }
    
    
}

extension HomeDetailViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblComments{
            return self.arrReview.count
        }else{
            return self.arrSel.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblComments{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableViewCell", for: indexPath) as! CommentTableViewCell

            cell.lblName.text = "\(self.arrReview[indexPath.row]["customer_name"].stringValue )"
            cell.lblReviewDescription.text = "\(self.arrReview[indexPath.row]["comment_msg"].stringValue )"
            cell.btnRating.setTitle("\(self.arrReview[indexPath.row]["rating_total"].stringValue )", for: .normal)
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "NearBySubTableViewCell", for: indexPath) as! NearBySubTableViewCell
            cell.lblName.text = "\(self.arrSel[indexPath.row]["text_show"].stringValue )"
            cell.lblKm.text = "\(self.arrSel[indexPath.row]["km_show"].stringValue ) KM"
           

            return cell
        }
    }
    
}




extension HomeDetailViewController{
    private func openRazorpayCheckout() {
        // 1. Initialize razorpay object with provided key. Also depending on your requirement you can assign delegate to self. It can be one of the protocol from RazorpayPaymentCompletionProtocolWithData, RazorpayPaymentCompletionProtocol.
        razorpayObj = RazorpayCheckout.initWithKey(razorpayKey, andDelegate: self)
        
        if let user = Preference.shared.getUserDetails()
        {
           
            //            if let url = URL(string:AppUrl.ImageUrl +  user["user_avatar"].stringValue)
            //            {
            //                imgProfile.sd_setImage(with: url, placeholderImage: UIImage(named: "kpLogo"))
            //            }
            
            let options: [AnyHashable:Any] = [
                "prefill": [
                    "contact": user["user_moblie_no"].stringValue,
                    "email": user["user_email"].stringValue
                    //                "method":"wallet",
                    //                "wallet":"amazonpay"
                ],
                "image": "http://www.freepngimg.com/download/light/2-2-light-free-download-png.png",
                "amount" : "\(self.dictHotel["discount_price"]?.stringValue ?? "0")00",
                //"timeout":10,
                "theme": [
                    "color": "#F37254"
                ]//            "order_id": "order_B2i2MSq6STNKZV"
                // and all other options
            ]
            if let rzp = self.razorpayObj {
                rzp.open(options)
            } else {
                print("Unable to initialize")
            }
        }
        
    }
}

extension HomeDetailViewController : RazorpayPaymentCompletionProtocol {
    
    func onPaymentError(_ code: Int32, description str: String) {
        print("error: ", code, str)
        self.presentAlert(withTitle: "Alert", message: str)
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
    }
}

extension HomeDetailViewController: RazorpayPaymentCompletionProtocolWithData {
    
    func onPaymentError(_ code: Int32, description str: String, andData response: [AnyHashable : Any]?) {
        print("error: ", code)
        self.presentAlert(withTitle: "Alert", message: str)
    }
    
    func onPaymentSuccess(_ payment_id: String, andData response: [AnyHashable : Any]?) {
        print("success: ", payment_id)
        self.presentAlert(withTitle: "Success", message: "Payment Succeeded")
    }
}

extension HomeDetailViewController {
    func presentAlert(withTitle title: String?, message : String?) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "Okay", style: .default)
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}


class MyDatePicker: UIView {
    
    var changeClosure: ((Date)->())?
    var dismissClosure: (()->())?

    let dPicker: UIDatePicker = {
        let v = UIDatePicker()
        v.datePickerMode = .date
        return v
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    func commonInit() -> Void {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)

        let pickerHolderView: UIView = {
            let v = UIView()
            v.backgroundColor = .white
            v.layer.cornerRadius = 8
            return v
        }()
        
        [blurredEffectView, pickerHolderView, dPicker].forEach { v in
            v.translatesAutoresizingMaskIntoConstraints = false
        }

        addSubview(blurredEffectView)
        pickerHolderView.addSubview(dPicker)
        addSubview(pickerHolderView)
        
        NSLayoutConstraint.activate([
            
            blurredEffectView.topAnchor.constraint(equalTo: topAnchor),
            blurredEffectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurredEffectView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurredEffectView.bottomAnchor.constraint(equalTo: bottomAnchor),

            pickerHolderView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0),
            pickerHolderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20.0),
            pickerHolderView.centerYAnchor.constraint(equalTo: centerYAnchor),

            dPicker.topAnchor.constraint(equalTo: pickerHolderView.topAnchor, constant: 20.0),
            dPicker.leadingAnchor.constraint(equalTo: pickerHolderView.leadingAnchor, constant: 20.0),
            dPicker.trailingAnchor.constraint(equalTo: pickerHolderView.trailingAnchor, constant: -20.0),
            dPicker.bottomAnchor.constraint(equalTo: pickerHolderView.bottomAnchor, constant: -20.0),

        ])
        
        if #available(iOS 14.0, *) {
            dPicker.preferredDatePickerStyle = .inline
        } else {
            // use default
        }
        
        dPicker.addTarget(self, action: #selector(didChangeDate(_:)), for: .valueChanged)
        
        let t = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        blurredEffectView.addGestureRecognizer(t)
    }
    
    @objc func tapHandler(_ g: UITapGestureRecognizer) -> Void {
        dismissClosure?()
    }
    
    @objc func didChangeDate(_ sender: UIDatePicker) -> Void {
        changeClosure?(sender.date)
    }
    
}

extension Date {
    func add(_ unit: Calendar.Component, value: Int) -> Date? {
        return Calendar.current.date(byAdding: unit, value: value, to: self)
    }
}

//
//  OfferVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 29/01/23.
//

import UIKit

class OfferVC: UIViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblbGetPacking: UILabel!
    
    @IBOutlet weak var btnBookNow: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        headerView.addShadow(offset: CGSize.init(width: 0, height: 1), color: UIColor.lightGray, radius: 2.0, opacity: 0.4)
        btnBookNow.addShadow(offset: CGSize.init(width: -1, height: 3), color: UIColor.lightGray, radius: 3.0, opacity: 0.4)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateSideMenu(_:)), name: NSNotification.Name(rawValue:"sidemenu"), object: nil)
        
        setupShareButton()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    

    @IBAction func btnBookNowTapped(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

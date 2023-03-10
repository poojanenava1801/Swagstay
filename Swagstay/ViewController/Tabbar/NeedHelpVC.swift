//
//  NeedHelpVC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 29/01/23.
//

import UIKit

class NeedHelpVC: UIViewController {
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var viewShadow: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true

        headerView.addShadow(offset: CGSize.init(width: 0, height: 1), color: UIColor.lightGray, radius: 2.0, opacity: 0.4)
        viewShadow.addShadow(offset: CGSize.init(width: 0, height: 10), color: UIColor.darkGray, radius: 2.0, opacity: 0.4)
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateSideMenu(_:)), name: NSNotification.Name(rawValue:"sidemenu"), object: nil)
        setupShareButton()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
}

//
//  Welcome1VC.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 28/01/23.
//

import UIKit
import CoreLocation

class Welcome1VC: UIViewController {

    //outlets
    @IBOutlet weak var btnSkip: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    var locManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupinitial()
    }
    

    func setupinitial(){
        self.lblDescription.text = "Hi thankyou for signup\nWe are available 24/7 to assist youduring stay,\nour customer care number is 9209228942\nAs we are growing, do follow our social media\nPage to get amazing offers and updates"
        
        locManager.requestWhenInUseAuthorization()
    }

    @IBAction func btnNextTapped(_ sender: UIButton) {
        let vc = GetOTPVC.instantiate(storyboard: .main)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

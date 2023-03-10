//
//  ViewController.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 28/01/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgIcon: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let jeremyGif = UIImage.gifImageWithName("login_gif")
          let imageView = UIImageView(image: jeremyGif)
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
          view.addSubview(imageView)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+6.0) {
            if let userCdId = Preference.shared.getUserCdId(){
                let home = TabBarVC()
                UIApplication.shared.windows.first?.rootViewController = home
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            }else{
                let home = Welcome1VC.instantiate(storyboard: .main)
                self.navigationController?.pushViewController(home, animated: true)
            }
        }
        
        
    }


}


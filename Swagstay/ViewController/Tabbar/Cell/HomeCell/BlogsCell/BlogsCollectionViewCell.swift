//
//  BlogsCollectionViewCell.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 11/02/23.
//

import UIKit

class BlogsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewBg: UIView!
    
    @IBOutlet weak var lblTagLine: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgHotel: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let shadowSize : CGFloat = 5.0
            let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                       y: -shadowSize / 2,
                                                       width: self.viewBg.frame.size.width + shadowSize,
                                                       height: self.viewBg.frame.size.height + shadowSize))
            self.viewBg.layer.masksToBounds = false
            self.viewBg.layer.shadowPath = shadowPath.cgPath
        
        imgHotel.roundCorners([.topLeft,.topRight], radius: 10)    }

}

//
//  HotelCollectionViewCell.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 07/02/23.
//

import UIKit

class HotelCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var imgHotel: UIImageView!
    @IBOutlet weak var viewRatingBelow: UIView!
    @IBOutlet weak var viewRatingUpper: UIView!
    @IBOutlet weak var lblRatingUper: UILabel!
    @IBOutlet weak var lblRatingBelow: UILabel!
    @IBOutlet weak var lblHotelName: UILabel!
    @IBOutlet weak var lblHotelAddress: UILabel!
    @IBOutlet weak var lblLowestPrice: UILabel!
    @IBOutlet weak var lblDiscountPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let shadowSize : CGFloat = 5.0
            let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                       y: -shadowSize / 2,
                                                       width: self.viewBg.frame.size.width + shadowSize,
                                                       height: self.viewBg.frame.size.height + shadowSize))
            self.viewBg.layer.masksToBounds = false
            self.viewBg.layer.shadowPath = shadowPath.cgPath
        
        imgHotel.roundCorners([.topLeft,.topRight], radius: 10)
    }

}

//
//  TodayDealsCollectionViewCell.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 09/02/23.
//

import UIKit

class TodayDealsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblDiscountPrice: UILabel!
    @IBOutlet weak var lblLowestPrice: UILabel!
    @IBOutlet weak var lblDiscountPercent: UILabel!
    @IBOutlet weak var lblHotelAddress: UILabel!
    @IBOutlet weak var lblHotelName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var imgHotel: UIImageView!
    @IBOutlet weak var viewBg: UIView!
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

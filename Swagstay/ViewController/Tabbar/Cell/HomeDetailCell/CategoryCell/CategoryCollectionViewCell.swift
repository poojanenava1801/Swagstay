//
//  CategoryCollectionViewCell.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 26/02/23.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblRoomType: UILabel!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var btnSelected: UIButton!
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
        
        imgHotel.roundCorners([.topLeft,.topRight], radius: 10)
    }

}

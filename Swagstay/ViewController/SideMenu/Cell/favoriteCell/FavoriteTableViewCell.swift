//
//  FavoriteTableViewCell.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 12/02/23.
//

import UIKit
import Cosmos

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var imgHotel: UIImageView!
    @IBOutlet weak var btnFav: UIButton!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgHotel.roundCorners([.topLeft,.topRight], radius: 15)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

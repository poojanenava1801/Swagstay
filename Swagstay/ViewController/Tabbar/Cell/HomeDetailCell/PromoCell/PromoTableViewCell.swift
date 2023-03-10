//
//  PromoTableViewCell.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 05/03/23.
//

import UIKit

class PromoTableViewCell: UITableViewCell {

    @IBOutlet weak var btnPromoCode: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

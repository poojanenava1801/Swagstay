//
//  BookingTableViewCell.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 06/02/23.
//

import UIKit

class BookingTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDateGuest: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgHotel: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

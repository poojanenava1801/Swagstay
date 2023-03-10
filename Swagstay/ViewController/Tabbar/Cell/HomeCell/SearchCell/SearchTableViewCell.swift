//
//  SearchTableViewCell.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 08/03/23.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var lblHotelName: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var imgMap: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

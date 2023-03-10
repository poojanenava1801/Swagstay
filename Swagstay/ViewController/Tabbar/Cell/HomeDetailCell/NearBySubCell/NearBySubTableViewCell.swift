//
//  NearBySubTableViewCell.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 07/03/23.
//

import UIKit

class NearBySubTableViewCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblKm: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

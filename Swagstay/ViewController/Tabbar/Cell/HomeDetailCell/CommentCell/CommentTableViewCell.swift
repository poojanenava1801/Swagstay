//
//  CommentTableViewCell.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 05/03/23.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnRating: UIButton!
    
    @IBOutlet weak var lblReviewDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

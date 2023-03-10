//
//  TransactionTableViewCell.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 11/02/23.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblThroughDescription: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var viewDate: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        let shadowSize : CGFloat = 2.0
            let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                       y: -shadowSize / 2,
                                                       width: self.viewDate.frame.size.width + shadowSize,
                                                       height: self.viewDate.frame.size.height + shadowSize))
            self.viewDate.layer.masksToBounds = false
            self.viewDate.layer.shadowPath = shadowPath.cgPath    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

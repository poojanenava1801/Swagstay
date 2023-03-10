//
//  AddRoomTableViewCell.swift
//  Swagstay
//
//  Created by Arpit singh mandloi on 04/03/23.
//

import UIKit

class AddRoomTableViewCell: UITableViewCell {

    @IBOutlet weak var viewChildren: UIView!
    @IBOutlet weak var lblRoom: UILabel!
    @IBOutlet weak var btnDelete: UIButton!
    
    @IBOutlet weak var btntravelWithChildrenCheckBox: UIButton!
    
    @IBOutlet weak var btnOneAdult: UIButton!
    
    @IBOutlet weak var btnTwoAdult: UIButton!
    
    @IBOutlet weak var btnAddRoom: UIButton!
    @IBOutlet weak var btnThreeAdult: UIButton!
    
    @IBOutlet weak var btnOneChildren: UIButton!
    
    @IBOutlet weak var svAddDelete: UIStackView!
    @IBOutlet weak var btnThreeChildren: UIButton!
    @IBOutlet weak var btnTwoChildren: UIButton!
    @IBOutlet weak var viewSapraterAboveSvAddDelete: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewChildren.isHidden = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

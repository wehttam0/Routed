//
//  OptionsCell.swift
//  cityride
//
//  Created by Matthew Attou on 5/21/16.
//  Copyright © 2016 Matthew Attou. All rights reserved.
//

import UIKit

class OptionsCell: UITableViewCell {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
}

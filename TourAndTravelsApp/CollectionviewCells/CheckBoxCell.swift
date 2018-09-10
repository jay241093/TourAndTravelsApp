//
//  CheckBoxCell.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/7/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit

class CheckBoxCell: UITableViewCell {

    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var checkbox: Checkbox!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

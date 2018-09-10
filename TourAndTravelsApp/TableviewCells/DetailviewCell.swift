//
//  DetailviewCell.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/27/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit

class DetailviewCell: UITableViewCell {
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var lblname: UILabel!
    
@IBOutlet weak var lbldes: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

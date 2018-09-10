//
//  DetailCellHistory.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/30/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit

class DetailCellHistory: UITableViewCell {
    @IBOutlet weak var lblinclusions: UILabel!
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var view: UIView!

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

//
//  FavouriteCell.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/8/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit

class FavouriteCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lbldays: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

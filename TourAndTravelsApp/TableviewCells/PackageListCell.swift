//
//  PackageListCell.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/23/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit

class PackageListCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var height: NSLayoutConstraint!
    
    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var btnlike: UIButton!
    
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var btnday: UIButton!
    
    @IBOutlet weak var lbldiscription: UILabel!
    @IBOutlet weak var lbldays: UILabel!
    
    @IBOutlet weak var lblprice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

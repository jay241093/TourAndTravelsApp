//
//  PackageDetailCell.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/23/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit

class PackageDetailCell: UITableViewCell {

    @IBOutlet weak var lbllocation: UILabel!
    
    @IBOutlet weak var btnshare: UIButton!
    @IBOutlet weak var lblexpireOn: UILabel!
    
    @IBOutlet weak var btnlike: UIButton!
    @IBOutlet weak var lblDays: UILabel!
    @IBOutlet weak var view1: UIView!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var lbldes: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    
    @IBOutlet weak var lblCityStays: UILabel!
    
    @IBOutlet weak var btnflight: UIButton!
    
    @IBOutlet weak var btnhotel: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  SearchCityCell.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 8/29/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit

class SearchCityCell: UITableViewCell {

    @IBOutlet weak var lblname: UILabel!
    @IBOutlet weak var voew: UIView!
    
    @IBOutlet weak var lblstatename: UILabel!
    
    @IBOutlet weak var lblhight: NSLayoutConstraint!
    
    @IBOutlet weak var lbldes: UILabel!
    
    @IBOutlet weak var btnreadmore: UIButton!
    
    @IBOutlet weak var btnadd: UIButton!
    
    @IBOutlet weak var btnviewmore: UIButton!
    
    @IBOutlet weak var lblsidemenu: UILabel!
    
    @IBOutlet weak var imgview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

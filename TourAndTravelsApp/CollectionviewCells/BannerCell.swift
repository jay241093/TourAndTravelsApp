//
//  BannerCell.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/12/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit

class BannerCell: UICollectionViewCell {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var lbltag: UILabel!
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var lbldes: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

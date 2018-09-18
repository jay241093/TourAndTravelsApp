//
//  ReviewCell.swift
//  TourAndTravelsApp
//
//  Created by Ravi Dubey on 9/11/18.
//  Copyright © 2018 Ravi Dubey. All rights reserved.
//

import UIKit
import FloatRatingView
class ReviewCell: UITableViewCell {
    @IBOutlet weak var imgview: UIImageView!
    @IBOutlet weak var ratingview: FloatRatingView!
    
    @IBOutlet weak var lblcomment: UILabel!
    @IBOutlet weak var lblname: UILabel!
    
    @IBOutlet weak var hight: NSLayoutConstraint!
    @IBOutlet weak var btnviewmore: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

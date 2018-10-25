//
//  infoDetailsCell.swift
//  OnDemandSaloon
//
//  Created by PS on 23/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import FloatRatingView

class infoDetailsCell: UITableViewCell {

    
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblusername: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var rateCellBackView: UIView!
    
    @IBOutlet weak var userRatings: FloatRatingView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

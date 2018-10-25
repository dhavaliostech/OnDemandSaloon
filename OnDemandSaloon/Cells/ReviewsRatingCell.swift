//
//  ReviewsRatingCell.swift
//  demo1
//
//  Created by PS on 31/07/18.
//  Copyright © 2018 PS. All rights reserved.
//

import UIKit
import FloatRatingView

class ReviewsRatingCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var RatingView: FloatRatingView!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var lblrRating: UILabel!
    @IBOutlet weak var lblNameOfSaloon: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

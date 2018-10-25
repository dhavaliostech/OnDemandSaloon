//
//  TodayOffersTableViewCell.swift
//  demo1
//
//  Created by PS on 01/08/18.
//  Copyright © 2018 PS. All rights reserved.
//

import UIKit
import FloatRatingView
class TodayOffersTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!

    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var BackView: UIView!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

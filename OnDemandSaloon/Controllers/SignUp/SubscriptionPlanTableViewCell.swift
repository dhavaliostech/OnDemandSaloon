//
//  SubscriptionPlanTableViewCell.swift
//  dummySalon
//
//  Created by Macbook Pro on 21/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class SubscriptionPlanTableViewCell: UITableViewCell {

    @IBOutlet weak var imgFirst: UIImageView!
    @IBOutlet weak var imgSecond: UIImageView!
    
    @IBOutlet weak var imgThird: UIImageView!
    @IBOutlet weak var lblThirdMonth: UILabel!
    
    @IBOutlet weak var lblSecond: UILabel!
    
    @IBOutlet weak var lblFirstMonth: UILabel!
    
    @IBOutlet weak var lblSubscription: UILabel!
    
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  SubscriptionFooterCell.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 02/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class SubscriptionFooterCell: UITableViewCell {

    
    @IBOutlet weak var btnFirst: UIButton!
    @IBOutlet weak var btnSecond: UIButton!
    @IBOutlet weak var btnThird: UIButton!
    
    @IBOutlet weak var imgFirst: UIImageView!
    @IBOutlet weak var imgSecond: UIImageView!
    @IBOutlet weak var imgThird: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

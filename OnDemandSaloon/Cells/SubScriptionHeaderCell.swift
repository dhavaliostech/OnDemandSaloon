//
//  SubScriptionHeaderCell.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 02/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class SubScriptionHeaderCell: UITableViewCell {

    @IBOutlet weak var firstPrice: UILabel!
    
    @IBOutlet weak var secondPrice: UILabel!
    @IBOutlet weak var thirdPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

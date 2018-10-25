//
//  ServiceAppointmentTableViewCell.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 26/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class ServiceAppointmentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblService: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

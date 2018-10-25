//
//  ViewOffersAdminCell.swift
//  demo1
//
//  Created by PS on 08/08/18.
//  Copyright © 2018 PS. All rights reserved.
//

import UIKit

class ViewOffersAdminCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var btnEdit: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


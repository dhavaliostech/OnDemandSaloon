//
//  PriceAndServicesTableViewCell.swift
//  dummySalon
//
//  Created by Macbook Pro on 21/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class PriceAndServicesTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var lblServices: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var btnTime: UIButton!
    
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnPrice: UIButton!
    @IBOutlet weak var txtFieldPrice: UITextField!
    
    @IBOutlet weak var imageDelete: UIImageView!
    @IBOutlet weak var txtFieldTime: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

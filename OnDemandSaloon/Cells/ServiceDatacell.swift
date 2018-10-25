//
//  ServiceDatacell.swift
//  OnDemandSaloon
//
//  Created by Pratik Zankat on 11/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class ServiceDatacell: UITableViewCell {

    @IBOutlet var imgPlus: UIImageView!
    @IBOutlet var btncall: UIButton!
    @IBOutlet var btnBook: UIButton!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblService: UILabel!
    @IBOutlet var ServiceImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  BookingTableViewCell.swift
//  dummySalon
//
//  Created by Macbook Pro on 19/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class BookingTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryName: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    
    @IBOutlet weak var priceView: UIView!
    
    @IBOutlet weak var btnBook: UIButton!
    
    @IBOutlet weak var btnCall: UIButton!
    
    @IBOutlet weak var btnAdd: UIButton!
    
    @IBOutlet weak var imgAddAndStatus: UIImageView!
    
    @IBOutlet weak var catView: UIView!
    @IBOutlet weak var catagoryIMG: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

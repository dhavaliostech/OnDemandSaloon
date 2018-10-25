//
//  Work_dayCell.swift
//  SalonApp
//
//  Created by MANISH CHAUHAN on 7/20/18.
//  Copyright © 2018 MANISH CHAUHAN. All rights reserved.
//

import UIKit

class Work_dayCell: UITableViewCell {

    @IBOutlet weak var bgview: UIView!
    
    @IBOutlet weak var btnChekmark: UIButton!
    
    @IBOutlet weak var lblDay: UILabel!
    
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var btnStartTime: UIButton!
    
    @IBOutlet weak var lblEndTime: UILabel!
    
    @IBOutlet weak var btnEndTime: UIButton!

    @IBOutlet weak var checkImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

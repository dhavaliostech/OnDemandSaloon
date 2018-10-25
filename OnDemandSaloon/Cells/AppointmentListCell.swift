//
//  AppointmentListCell.swift
//  SalonApp
//
//  Created by MANISH CHAUHAN on 7/17/18.
//  Copyright © 2018 MANISH CHAUHAN. All rights reserved.
//

import UIKit

class AppointmentListCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var TimeImage: UIImageView!
    @IBOutlet weak var lblConfirmed: UILabel!
    @IBOutlet weak var lblHairStyle: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    
    @IBOutlet weak var lblSalonName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
         cellView.layer.borderWidth = 1
         cellView.layer.borderColor = UIColor.lightGray.cgColor
        
    
    }
   
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

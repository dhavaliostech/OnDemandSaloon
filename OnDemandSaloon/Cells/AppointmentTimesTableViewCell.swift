//
//  AppointmentTimesTableViewCell.swift
//  dummySalon
//
//  Created by Macbook Pro on 16/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class AppointmentTimesTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTImeSection: UILabel!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var appointmentTimeCollectionView: UICollectionView!
    
    @IBOutlet weak var statusLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       // heightConstraint.constant = collectionViewHeight
    }

    var collectionViewHeight : CGFloat{
        
        appointmentTimeCollectionView.layoutIfNeeded()
        return appointmentTimeCollectionView.contentSize.height
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

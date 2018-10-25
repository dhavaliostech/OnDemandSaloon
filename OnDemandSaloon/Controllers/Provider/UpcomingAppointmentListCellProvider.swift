//
//  UpcomingAppointmentListCell.swift
//  SalonApp
//
//  Created by MANISH CHAUHAN on 7/21/18.
//  Copyright © 2018 MANISH CHAUHAN. All rights reserved.
//

import UIKit

class UpcomingAppointmentListCellProvider: UICollectionViewCell {
    
    @IBOutlet weak var ProfileImage: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblService: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var lblDay: UILabel!
    
    @IBOutlet weak var btnReject: UIButton!
    
    @IBOutlet weak var btnAccept: UIButton!
}

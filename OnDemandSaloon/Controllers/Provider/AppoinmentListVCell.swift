//
//  AppoinmentListVCell.swift
//  OnDemandSaloon
//
//  Created by Saavaj on 10/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class AppoinmentListVCell: UITableViewCell {
    
    @IBOutlet weak var UserProfile: UIImageView!
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblDate: UILabel!
    
    @IBOutlet weak var lblService: UILabel!
    
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var btnReject: UIButton!
    
    @IBOutlet weak var btnAccept: UIButton!
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var acceptRejectView: UIView!
    
    @IBOutlet weak var statusView: UIView!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        
    }
    
    override func layoutSubviews() {
        
        self.UserProfile.layer.cornerRadius = self.UserProfile.frame.size.height / 2
        self.UserProfile.clipsToBounds = true
//        self.UserProfile.layer.borderWidth = 0.5
//        self.UserProfile.layer.borderColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

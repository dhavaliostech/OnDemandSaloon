//
//  ClientListTableViewCell.swift
//  dummySalon
//
//  Created by Macbook Pro on 21/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class ClientListTableViewCell: UITableViewCell {

    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var lblUserName: UILabel!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var lblUserContactNumber: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {

        self.imgUser.layer.cornerRadius = self.imgUser.frame.size.height / 2
        self.imgUser.clipsToBounds = true
        self.imgUser.layer.borderWidth = 0.5
        self.imgUser.layer.borderColor = UIColor.init(red: 0/255, green: 102/255, blue: 176/255, alpha: 1).cgColor
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

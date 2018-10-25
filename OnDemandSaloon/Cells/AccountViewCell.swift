//
//  AccountViewCell.swift
//  OnDemandSaloon
//
//  Created by Saavaj on 07/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class AccountViewCell: UITableViewCell {

    @IBOutlet weak var lblFirstQuestion: UILabel!
    
    @IBOutlet weak var btnAction: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var bgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.bgView.layer.borderWidth = 0.5
         self.bgView.layer.borderColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

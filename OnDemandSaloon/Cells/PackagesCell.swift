//
//  PackagesCell.swift
//  SalonApp
//
//  Created by Pratik Zankat on 19/07/18.
//  Copyright © 2018 MANISH CHAUHAN. All rights reserved.
//

import UIKit

class PackagesCell: UICollectionViewCell {
    
    @IBOutlet var bgimage: UIImageView!
    
    @IBOutlet var lblPrice: UILabel!
    
    @IBOutlet var lbl1: UILabel!
    
    @IBOutlet var lbl2: UILabel!
    
    @IBOutlet var lbl3: UILabel!
    
    @IBOutlet var lbl4: UILabel!
    
    @IBOutlet var lbl5: UILabel!
    
    @IBOutlet var btnBuyNow: UIButton!
    
    @IBOutlet weak var serviceTableView: UITableView!
    @IBOutlet weak var buyConstraint: NSLayoutConstraint!
   
    @IBOutlet weak var serviceConstraint: NSLayoutConstraint!
    
}

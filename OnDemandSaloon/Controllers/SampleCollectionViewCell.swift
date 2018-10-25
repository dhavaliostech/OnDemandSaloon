//
//  SampleCollectionViewCell.swift
//  dummySalon
//
//  Created by Macbook Pro on 19/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class SampleCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainTableview: UITableView!
    
    var tableViewHeight: CGFloat {
        mainTableview.layoutIfNeeded()
        
        return mainTableview.contentSize.height
    }
    
}

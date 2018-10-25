//
//  CatagorySelectionCollectionViewCell.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 06/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class CatagorySelectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var btnSected: UIButton!
    @IBOutlet weak var categoryBackView: UIView!
    
    @IBOutlet weak var catagoryImage: UIImageView!
    
    @IBOutlet weak var catagoryName: UILabel!
    
    override var bounds: CGRect {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.catagoryImage.layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setCircularImageView()
    }
    
    func setCircularImageView() {
        self.catagoryImage.layer.cornerRadius = CGFloat(roundf(Float(self.catagoryImage.frame.size.width / 2.0)))
    }
}

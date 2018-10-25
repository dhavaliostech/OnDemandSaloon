//
//  SearchResultForCollectionViewCell.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 28/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import FloatRatingView

class SearchResultForCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var imgInfoBack: UIImageView!
    
    @IBOutlet weak var lblSalonName: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    @IBOutlet weak var lblReviews: UILabel!
    
    @IBOutlet weak var lblHappyCustomer: UILabel!
    
    @IBOutlet weak var ratingView: FloatRatingView!
    
    @IBOutlet weak var salonImage: UIImageView!
    
}

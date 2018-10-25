//
//  SearchResultCollectionViewCell.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 11/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit
import FloatRatingView

class SearchResultCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var detailSearchView: UIView!
    @IBOutlet weak var strImage: UIImageView!
    
    @IBOutlet weak var ratingView: FloatRatingView!
    
    @IBOutlet weak var lblSaloonName: UILabel!
    
    @IBOutlet weak var lblReview: UILabel!
    
    @IBOutlet weak var lblPercentageHappyCustomer: UILabel!
    
    @IBOutlet weak var lblLocation: UILabel!
    
    
}

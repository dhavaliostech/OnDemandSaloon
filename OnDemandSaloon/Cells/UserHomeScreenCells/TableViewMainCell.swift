//
//  TableViewMainCell.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 06/07/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class TableViewMainCell: UITableViewCell {

    @IBOutlet weak var mainCellCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

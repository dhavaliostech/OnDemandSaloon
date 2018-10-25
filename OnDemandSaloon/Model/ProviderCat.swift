//
//  ProviderCat.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 01/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class ProviderCat: NSObject {

    var mainCat:String!
    var mainCatID:String!
    
    var mySelectedCat:[ProviderCat] = []
    
    init(dict:[String:Any]) {
        mainCat = "\(dict["ser_name"] ?? "" )"
        mainCatID = "\(dict["ser_id"] ?? "" )"
  
    }
}

class SelectedCat: NSObject {
    
    var mainCat:String!
    var mainCatID:String!
    
    var mySelectedCat:[ProviderCat] = []
    
    init(dict:[String:Any]) {
        mainCat = "\(dict["ser_name"] ?? "" )"
        mainCatID = "\(dict["ser_id"] ?? "" )"
        
    }
}

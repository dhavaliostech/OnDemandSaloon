//
//  ServiceListBasedOnMainCat.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 02/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class ServiceListBasedOnMainCat: NSObject {

    var ser_cat_id :String!
    var ser_cat_name:String!
    var ser_cat_parent:String!
    var ser_cat_price:String!
    var ser_cat_time:String!
    
    init(dict:[String:Any]) {
        ser_cat_id = "\(dict["ser_cat_id"] ?? "")"
        ser_cat_name = "\(dict["ser_cat_name"] ?? "")"
        ser_cat_parent = "\(dict["ser_cat_parent"] ?? "")"
        ser_cat_price = "\(dict["ser_cat_price"] ?? "")"
        ser_cat_time = "\(dict["ser_cat_time"] ?? "")"
    }
}


//
//  AddCategory.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 04/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class AddCategory: NSObject {

    var strSer_id :String!
    var strSer_name:String
    var strSer_created_by :String!
    var strSer_img:String!
    var strSer_status:String!
    
    init(dict:[String:Any]) {

        strSer_id = "\(dict["ser_id"] ?? "")"
        strSer_name = "\(dict["ser_name"] ?? "")"
        strSer_created_by = "\(dict["ser_created_by"] ?? "")"
        strSer_img = "\(dict["ser_img"] ?? "")"
        strSer_status = "\(dict["ser_status"] ?? "")"
    }
    
    
}


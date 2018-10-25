//
//  ListOfMainCategories.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 21/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class ListOfMainCategories: NSObject {
 
    var ser_ID :String!
    var ser_Name :String!
    var ser_Created_by :String!
    var ser_Img :String!
    var ser_Status :String!

    init(dict:[String:Any]) {
    
        ser_ID = "\(dict["ser_id"] ?? "")"
        ser_Name = "\(dict["ser_name"] ?? "")"
        ser_Created_by = "\(dict["ser_created_by"] ?? "")"
        ser_Img = "\(dict["ser_img"] ?? "")"
        ser_Status = "\(dict["ser_status"] ?? "")"
    }
  
}

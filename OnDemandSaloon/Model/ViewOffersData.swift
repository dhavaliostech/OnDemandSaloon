//
//  ViewOffersData.swift
//  OnDemandSaloon
//
//  Created by Saavaj on 07/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class ViewOffersData: NSObject {

    var off_id:String!
    var off_name:String!
    var off_desc:String!
    var off_start_date:String!
    var off_end_date:String!
    var off_services_id:String!
    var business_name:String!
    var id:String!
    var user_location:String!
    var banner_name:String!
    var rat_out_of_5:String!
    var total_review:String!
    
    init(dict:[String:Any]){
        
        off_id = "\(dict["off_id"] ?? "")"
        off_name = "\(dict["off_name"] ?? "")"
        off_desc = "\(dict["off_desc"] ?? "")"
        off_start_date = "\(dict["off_start_date"] ?? "")"
        off_end_date = "\(dict["off_end_date"] ?? "")"
        off_services_id = "\(dict["off_services_id"] ?? "")"
        business_name = "\(dict["business_name"] ?? "")"
        id = "\(dict["id"] ?? "")"
        user_location = "\(dict["user_location"] ?? "")"
        banner_name = "\(dict["banner_name"] ?? "")"
        rat_out_of_5 = "\(dict["rat_out_of_5"] ?? "")"
        total_review = "\(dict["total_review"] ?? "")"
 
    }
 
}

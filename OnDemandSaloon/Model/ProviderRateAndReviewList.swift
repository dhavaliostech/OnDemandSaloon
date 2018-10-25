//
//  ProviderRateAndReviewList.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 07/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class ProviderRateAndReviewList: NSObject {
    
    var id:String!
    var user_fname:String!
    var user_lname:String!
    var rat_service_pro_id:String!
    var rat_out_of_5:String!
    var rat_discription:String!
    var rat_created_time:String!
    var rat_time:String!
    var rat_quality:String!
    var rat_safety:String!
    var rat_result:String!
    var rat_proffesnalism:String!
    var rat_rewarding:String!
    
    init(dict:[String:Any]) {
        
        id = "\(dict["id"] ?? "")"
        user_fname = "\(dict["user_fname"] ?? "")"
        user_lname = "\(dict["user_lname"] ?? "")"
        rat_service_pro_id = "\(dict["rat_service_pro_id"] ?? "")"
        rat_out_of_5 = "\(dict["rat_out_of_5"] ?? "")"
        rat_discription = "\(dict["rat_discription"] ?? "")"
        rat_created_time = "\(dict["rat_created_time"] ?? "")"
        rat_time = "\(dict["rat_time"] ?? "")"
        rat_quality = "\(dict["rat_quality"] ?? "")"
        rat_safety = "\(dict["rat_safety"] ?? "")"
        rat_result = "\(dict["rat_result"] ?? "")"
        rat_proffesnalism = "\(dict["rat_proffesnalism"] ?? "")"
        rat_rewarding = "\(dict["rat_rewarding"] ?? "")"
        
    }
    
}

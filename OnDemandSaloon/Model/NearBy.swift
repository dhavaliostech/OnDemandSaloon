//
//  NearBy.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 22/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class NearBy: NSObject {

    var salon_Id:String!
    var business_name:String!
    var user_location:String!
    var rat_out_of_5:String!
    var banner_name:String!
    var total_review:String!
    var happy_performance:String!
    
    init(dictionary:[String:Any]){
        
        salon_Id = "\(dictionary["id"] ?? "")"
        business_name = "\(dictionary["business_name"] ?? "")"
        user_location = "\(dictionary["user_location"] ?? "")"
        rat_out_of_5 = "\(dictionary["rat_out_of_5"] ?? "")"
        banner_name = "\(dictionary["banner_name"] ?? "")"
        total_review = "\(dictionary["total_review"] ?? "")"
        happy_performance = "\(dictionary["happy_performance"] ?? "")"
        
    }
    
}

//
//  UserRateReviews.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 17/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class UserRateReviews: NSObject {

    var ratId :String!
    var ratOutOf5 :String!
    var ratDiscription :String!
    var ratSalonName :String!
    var ratUserId :String!
    var ratCreatedTime :String!
    var rat_service_pro_id:String!
    var rat_role:String!
    var rat_time:String!
    var rat_quality:String!
    var rat_safety:String!
    var rat_result:String!
    var rat_proffesnalism:String!
    var rat_rewarding:String!
    
    init(dict:[String:Any]){

        ratId = "\(dict["id"] ?? "")"
        ratOutOf5 = "\(dict["rat_out_of_5"] ?? "")"
        ratDiscription = "\(dict["rat_discription"] ?? "")"
        ratSalonName = "\(dict["business_name"] ?? "")"
        ratUserId = "\(dict["rat_user_id"] ?? "")"
        ratCreatedTime = "\(dict["rat_created_time"] ?? "")"
        rat_service_pro_id = "\(dict["rat_service_pro_id"] ?? "")"
        rat_role = "\(dict["rat_role"] ?? "")"
        rat_time = "\(dict["rat_time"] ?? "")"
        rat_quality = "\(dict["rat_quality"] ?? "")"
        rat_safety = "\(dict["rat_safety"] ?? "")"
        rat_result = "\(dict["rat_result"] ?? "")"
        rat_proffesnalism = "\(dict["rat_proffesnalism"] ?? "")"
        rat_rewarding = "\(dict["rat_rewarding"] ?? "")"
    }
    
}

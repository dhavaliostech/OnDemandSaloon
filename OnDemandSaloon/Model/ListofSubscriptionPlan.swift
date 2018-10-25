//
//  ListofSubscriptionPlan.swift
//  WhatsappDemo
//
//  Created by Saavaj on 13/08/18.
//  Copyright © 2018 Saavaj. All rights reserved.
//

import UIKit

class ListofSubscriptionPlan: NSObject {

    var sp_add_category:String!
    var sp_add_employee:String!
    var sp_add_services:String!
    var sp_duration:String!
    var sp_id:String!
    var sp_personalized_setting:String!
    var sp_price:String!
    var mySP:MySubScriptionPlan!
    
    init(dict:[String:Any]) {
        
        sp_add_category = "\(dict["sp_add_category"] ?? "")"
        sp_add_employee = "\(dict["sp_add_employee"] ?? "")"
        sp_add_services = "\(dict["sp_add_services"] ?? "")"
        sp_duration = "\(dict["sp_duration"] ?? "")"
        sp_id = "\(dict["sp_id"] ?? "")"
        sp_personalized_setting = "\(dict["sp_personalized_setting"] ?? "")"
        sp_price = "\(dict["sp_price"] ?? "")"

    }


}

class MySubScriptionPlan :NSObject{
    
    var lang:String!
    var seb_plan_created_date:String!
    var sel_sp_id:String!
    var sel_sp_plan_id:String!
    var sel_sp_provider_id:String!
    var sel_sp_status:String!
    
    init(dict:[String:Any]) {
        
        lang = "\(dict["lang"] ?? "")"
        seb_plan_created_date = "\(dict["seb_plan_created_date"] ?? "")"
        sel_sp_id = "\(dict["sel_sp_id"] ?? "")"
        sel_sp_plan_id = "\(dict["sel_sp_plan_id"] ?? "")"
        sel_sp_provider_id = "\(dict["sel_sp_provider_id"] ?? "")"
        sel_sp_status = "\(dict["sel_sp_status"] ?? "")"
    }
}

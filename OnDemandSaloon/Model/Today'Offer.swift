//
//  Today'Offer.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 29/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class Today_Offer: NSObject {

    var Off_id:String!
    var Off_name:String!
    var off_desc:String!
    var off_start_date:String!
    var off_end_date:String!
    var off_services_id:String!
    var off_status:String!
    var id:String!
    var user_fname:String!
    var user_lname:String!
    var business_name:String!
    var user_phone:String!
    var user_location:String!
    var business_full_address:String!
    var city:String!
    var category_service:String!
    var images:String!
    var working_hours:String!
    var wh_from:String!
    var wh_to:String!
    var user_email:String!
    var user_password:String!
    var user_avatar:String!
    var latitude:String!
    var longitude:String!
    var role:String!
    var status:String!
    var oh_current_notes:String!
    var device_token:String!
    var device_type:String!
    var subscription:String!
    var user_type:String!
    var banner_id:String!
    var banner_name:String!
    var banner_service_id:String!
    var banner_status:String!
    var rat_id:String!
    var rat_out_of_5:String!
    var rat_time:String!
    var rat_quality:String!
    var rat_safety:String!
    var rat_result:String!
    var rat_proffesnalism:String!
    var rat_rewarding:String!
    var rat_discription:String!
    var rat_service_pro_id:String!
    var rat_give_by_user:String!
    var rat_role:String!
    var rat_created_time:String!

    init (dict:[String:Any]){
        
        Off_id = "\(dict["off_id"] ?? "")"
        Off_name = "\(dict["off_name"] ?? "")"
        off_desc = "\(dict["off_desc"] ?? "")"
        off_start_date = "\(dict["off_start_date"] ?? "")"
        off_end_date = "\(dict["off_end_date"] ?? "")"
        off_services_id = "\(dict["off_status"] ?? "")"
        off_status = "\(dict["off_status"] ?? "")"
        id = "\(dict["id"] ?? "")"
        user_fname = "\(dict["user_fname"] ?? "")"
        user_lname = "\(dict["user_lname"] ?? "")"
        business_name = "\(dict["business_name"] ?? "")"
        user_phone = "\(dict["user_phone"] ?? "")"
        user_location = "\(dict["user_location"] ?? "")"
        business_full_address = "\(dict["business_full_address"] ?? "")"
        city = "\(dict["city"] ?? "")"
        category_service = "\(dict["category_service"] ?? "")"
        images = "\(dict["images"] ?? "")"
        working_hours = "\(dict["working_hours"] ?? "")"
        wh_from = "\(dict["wh_from"] ?? "")"
        wh_to = "\(dict["wh_to"] ?? "")"
        user_email = "\(dict["user_email"] ?? "")"
        user_password = "\(dict["user_password"] ?? "")"
        user_avatar = "\(dict["user_avatar"] ?? "")"
        latitude = "\(dict["latitude"] ?? "")"
        longitude = "\(dict["longitude"] ?? "")"
        role = "\(dict["role"] ?? "")"
        status = "\(dict["status"] ?? "")"
        oh_current_notes = "\(dict["oh_current_notes"] ?? "")"
        device_token = "\(dict["device_token"] ?? "")"
        device_type = "\(dict["device_type"] ?? "")"
        subscription = "\(dict["subscription"] ?? "")"
        user_type = "\(dict["user_type"] ?? "")"
        banner_id = "\(dict["banner_id"] ?? "")"
        banner_name = "\(dict["banner_name"] ?? "")"
        banner_service_id = "\(dict["banner_service_id"] ?? "")"
        banner_status = "\(dict["banner_status"] ?? "")"
        rat_id = "\(dict["rat_id"] ?? "")"
        rat_out_of_5 = "\(dict["rat_out_of_5"] ?? "")"
        rat_time = "\(dict["rat_time"] ?? "")"
        rat_quality = "\(dict["rat_quality"] ?? "")"
        rat_safety = "\(dict["rat_safety"] ?? "")"
        rat_result = "\(dict["rat_result"] ?? "")"
        rat_proffesnalism = "\(dict["rat_proffesnalism"] ?? "")"
        rat_rewarding = "\(dict["rat_rewarding"] ?? "")"
        rat_discription = "\(dict["rat_discription"] ?? "")"
        rat_service_pro_id = "\(dict["rat_give_by_user"] ?? "")"
        rat_give_by_user = "\(dict["rat_give_by_user"] ?? "")"
        rat_role = "\(dict["rat_role"] ?? "")"
        rat_created_time = "\(dict["rat_created_time"] ?? "")"
        
    }
    
    
}

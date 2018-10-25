//
//  AppointmentlistData.swift
//  OnDemandSaloon
//
//  Created by Saavaj on 08/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class AppointmentlistData: NSObject {

    
    var app_status:String!
    var app_date:String!
    var app_service_time:String!
    var app_service_name:String!
    var id:String!
    var user_fname:String!
    var user_lname:String!
    var user_role:String!
    var service_list:[ServiceListArr] = []
    var user_avatar:String!
    var user_location:String!
    var user_phone:String!
    var app_book_status:String!
    
    init(dict:[String:Any]){
        
        app_status = "\(dict["app_status"] ?? "")"
        app_date = "\(dict["app_date"] ?? "")"
        app_service_time = "\(dict["app_service_time"] ?? "")"
        app_service_name = "\(dict["app_service_name"] ?? "")"
        id = "\(dict["id"] ?? "")"
        user_fname  = "\(dict["user_fname"] ?? "")"
        user_lname = "\(dict["user_lname"] ?? "")"
        user_role = "\(dict["user_role"] ?? "")"
        user_avatar = "\(dict["user_avatar"] ?? "")"
        user_location = "\(dict["user_location"] ?? "")"
        user_phone  = "\(dict["user_phone"] ?? "")"
        app_book_status = "\(dict["app_book_status"] ?? "")"
        
        if let getobj = dict["service_list"] as? [[String:Any]]{
            
            for i in getobj{
                service_list.append(ServiceListArr(dict: i))
            }
        }
       
    }
}

class ServiceListArr: NSObject {
    
    var ser_cs_id:String!
    var ser_cs_name:String!
    var ser_cs_price:String!
    
    init(dict:[String:Any]){
        
        ser_cs_id = "\(dict["ser_cs_id"] ?? "")"
        ser_cs_name = "\(dict["ser_cs_name"] ?? "")"
        ser_cs_price = "\(dict["ser_cs_price"] ?? "")"
    }
}



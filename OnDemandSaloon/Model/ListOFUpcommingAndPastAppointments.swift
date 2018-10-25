//
//  ListOFUpcommingAndPastAppointments.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 01/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class ListOFUpcommingAndPastAppointments: NSObject {

    var arrayOfUpcomming:[UserAppointment] = []
    var arrayOfPast:[UserAppointment] = []
    
    init(dict:[String:Any]) {

        if let pastAppointment = dict["past_appointment_list"] as? [[String:Any]]{
            
            for i in pastAppointment{
                arrayOfPast.append(UserAppointment(dict: i))
            }
    
        }
        
        if let upcomingAppointment = dict["upcoming_appointment_list"] as? [[String:Any]]{
            
            for i in upcomingAppointment{
                arrayOfUpcomming.append(UserAppointment(dict: i))
            }
            
            
        }
        
    }
    
}

class UserAppointment:NSObject{

    var app_status:String!
     var app_date:String!
     var business_name:String!
     var user_phone:String!
     var role:String!
     var provider_id:String!
     var service_list:[ServiceList] = []
    
    init(dict:[String:Any]) {
        
        app_status = "\(dict["app_status"] ?? "")"
        app_date = "\(dict["app_date"] ?? "")"
        business_name = "\(dict["business_name"] ?? "")"
        user_phone = "\(dict["user_phone"] ?? "")"
        role = "\(dict["role"] ?? "")"
        provider_id = "\(dict["provider_id"] ?? "")"
        
        if let serviceList = dict["service_list"] as? [[String:Any]]{
            
            for i in serviceList{
                service_list.append(ServiceList(dict: i))
            }
            
        }
        
    }
    
    
}

class ServiceList:NSObject{
//    "ser_cs_id": "2",
//    "ser_cs_name": "Hair Style"
    var ser_cs_id:String!
    var ser_cs_name:String!
    
    init(dict:[String:Any]) {
        
        ser_cs_id = "\(dict["ser_cs_id"] ?? "")"
        ser_cs_name = "\(dict["ser_cs_name"] ?? "")"
        
    }
    
}

//
//  SalonDetailsBasedOnId.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 25/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class SalonDetailsBasedOnId: NSObject {
    
    var catArray :[CatDetails] = []
    var catServiceArray:[CatSerDetails] = []
    var imageArray:[String] = []
    var timeInfo:[TimeInfo] = []
    var ratList:[RatingList] = []
    
    var serviceProviderId :String!
    var business_name:String!
    var user_location:String!
    var city:String!
    var user_phone:String!
    var banner_name:String!
    var rat_out_of_5:String!
    var total_review:String!
    var happy_customers:String!
    var salonAddress:String!
    var employeeList:[EmployeeeListAppointment] = []
    
    init(dict:[String:Any]){

        if let getData = dict["service_provider_details"] as? [String:Any]{
            
            serviceProviderId = "\(getData["id"] ?? "")"
            business_name = "\(getData["business_name"] ?? "")"
            user_location = "\(getData["user_location"] ?? "")"
            city = "\(getData["city"] ?? "")"
            user_phone = "\(getData["user_phone"] ?? "")"
            banner_name = "\(getData["banner_name"] ?? "")"
            rat_out_of_5 = "\(getData["rat_out_of_5"] ?? "")"
            total_review = "\(getData["total_review"] ?? "")"
            happy_customers = "\(getData["happy_customers"] ?? "")"
            salonAddress = "\(getData["business_full_address"] ?? "")"
        }
        
        if let getData = dict["banner_images"] as? [[String:Any]]{
            for i in getData{
                imageArray.append("\(i["banner_name"] ?? "")")
            }
        }
        
        if let getData = dict["category_details"] as? [[String:Any]]{
            for i in getData{
                catArray.append(CatDetails(dict: i))
            }
        }

        if let getData = dict["category_services_details"] as? [[String:Any]]{
            for i in getData{
                catServiceArray.append(CatSerDetails(dict: i))
            }
        }
        
        if let getData = dict["time_info"] as? [[String:Any]]{
            for i in getData{
                timeInfo.append(TimeInfo(dict: i))
            }
        }
        
        if let getData = dict["rating_lists"] as? [[String:Any]]{
            for i in getData{
                ratList.append(RatingList(dict: i))
            }
        }
        
        if let getData = dict["employee_list"] as? [[String:Any]]{
            for i in getData{
                employeeList.append(EmployeeeListAppointment(dict: i))
            }
        }
        
    }
    
}

class CatDetails : NSObject{
    
    var ser_ID:String!
    var ser_name:String!
    var sp_provider_id:String!
    
    init(dict:[String:Any]){
        
        ser_ID = "\(dict["ser_id"]  ?? "")"
        ser_name = "\(dict["ser_name"]  ?? "")"
        sp_provider_id = "\(dict["sp_provider_id"]  ?? "")"
        
    }
}

class CatSerDetails:NSObject{
    var sp_provider_id :String!
    var ser_cs_id:String!
    var ser_cs_name:String!
    var ser_cs_parent:String!
    var ser_cs_price:String!
    var ser_cs_time:String!
    var ser_cat_image:String!
    var selectedItem:Bool!
    var providerId:String!
    
    init(dict:[String:Any]){
        
        sp_provider_id = "\(dict["sp_provider_id"] ?? "" )"
        providerId = "\(dict["id"] ?? "")"
        ser_cs_id = "\(dict["ser_cs_id"] ?? "" )"
        ser_cs_name = "\(dict["ser_cs_name"] ?? "" )"
        ser_cs_parent = "\(dict["ser_cs_parent"] ?? "" )"
        ser_cs_price = "\(dict["ser_cs_price"] ?? "" )"
        ser_cs_time = "\(dict["ser_cs_time"] ?? "" )"
        ser_cat_image = "\(dict["ser_cat_image"] ?? "" )"
        selectedItem = false
    }
    
}

class TimeInfo: NSObject {
    var oh_day:String!
    var oh_from_time:String!
    var oh_to_time:String!
    
    init(dict:[String:Any]){
        
        oh_day = "\(dict["oh_day"] ?? "")"
        oh_from_time = "\(dict["oh_from_time"] ?? "")"
        oh_to_time = "\(dict["oh_to_time"] ?? "")"
    
    }
}

class RatingList:NSObject{
    var id :String!
    var user_frame:String!
    var user_lname:String!
    var rateOutOF5:String!
    var ratDiscription:String!
    var ratCreatedTime:String!
    var userImage:String!
    
    init(dict:[String:Any]){
        id = dict["id"] as! String
        user_frame = "\(dict["user_fname"] ?? "")"
        user_lname = "\(dict["user_lname"] ?? "")"
        rateOutOF5 = "\(dict["rat_out_of_5"] ?? "")"
        ratCreatedTime = "\(dict["rat_created_time"] ?? "")"
        ratDiscription = "\(dict["rat_discription"] ?? "")"
        userImage = "\(dict["user_avatar"] ?? "")"
        
    }
    
}

class EmployeeeListAppointment:NSObject{
    
    var em_id:String!
    var em_fname:String!
    var em_lname:String!
    var em_image:String!
    
    init(dict:[String:Any]) {
        
        em_id = "\(dict["em_id"] ?? "")"
        em_fname = "\(dict["em_fname"] ?? "")"
        em_lname = "\(dict["em_lname"] ?? "")"
        em_image = "\(dict["em_image"] ?? "")"
        
        
    }
}

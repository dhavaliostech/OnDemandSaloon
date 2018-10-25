//
//  UserProfileData.swift
//  OnDemandSaloon
//
//  Created by PS on 11/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class UserProfileData: NSObject {
        
    var strUserId:String!
    var strUser_FName:String!
    var strUser_LName:String!
    var strBusiness_name:String!
    var strUser_phone:String!
    var strUser_location:String!
    var strCity:String!
    var strCategory_service:String!
    var strWorking_hours:String!
    var strWh_from:String!
    var strWh_to:String!
    var strUser_email:String!
    var strUser_password:String!
    var strUser_avatar:String!
    var strLatitude:String!
    var strLongitude:String!
    var strRole:String!
    var strStatus:String!
    var strOh_current_notes:String!
    var strUser_token:String!
    //var strUserToken:String!
    
    init (dict:[String:Any]){
        
        strUserId = "\(dict["id"] ?? "")"
        strUser_FName = "\(dict["user_fname"] ?? "")"
        strUser_LName = "\(dict["user_lname"] ?? "")"
        strBusiness_name = "\(dict["business_name"] ?? "")"
        strUser_phone  = "\(dict["user_phone"] ?? "")"
        strUser_location = "\(dict["user_location"] ?? "")"
        strCity = "\(dict["city"] ?? "")"
        strCategory_service = "\(dict["category_service"] ?? "")"
        strWorking_hours = "\(dict["working_hours"] ?? "")"
        strWh_from = "\(dict["wh_from"] ?? "")"
        strWh_to = "\(dict["wh_to"] ?? "")"
        strUser_email = "\(dict["user_email"] ?? "")"
        strUser_password = "\(dict["user_password"] ?? "")"
        strUser_avatar = "\(dict["user_avatar"] ?? "")"
        strLatitude = "\(dict["latitude"] ?? "")"
        strLongitude = "\(dict["longitude"] ?? "")"
        strRole = "\(dict["role"] ?? "")"
        strStatus = "\(dict["status"] ?? "")"
        strOh_current_notes = "\(dict["oh_current_notes"] ?? "")"
        strUser_token = "\(dict["user_token"] ?? "")"
        
    }
    
}

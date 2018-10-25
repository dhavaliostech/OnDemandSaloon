//
//  profileAdd.swift
//  SalonApp
//
//  Created by Saavaj on 16/08/18.
//  Copyright © 2018 MANISH CHAUHAN. All rights reserved.
//

import UIKit

class ProfileAdd: NSObject {

    
    var strId:String!
    var strUserFname:String!
    var strUserLname:String!
    var strBusinessName:String!
    var strUserPhone:String!
    var strUserLocation:String!
    var strCity:String!
    var strCategoryService:String!
    var strImages:String!
    var strWorkingHours:String!
    var strWhFrom:String!
    var strWhTo:String!
    var strUserEmail:String!
    var strUserPassword:String!
    var strUserAvatar:String!
    var strLatitude:String!
    var strLongitude:String!
    var strRole:String!
    var strStatus:String!
    var strOhCurrentNotes:String!
    var strUserToken:String!
    var strUserType:String!
    var strSubscription:String!
    
   init(dict:[String:Any]) {
    
    strId =  "\(dict["id"] ?? "")"
    strUserFname = "\(dict["user_fname"] ?? "")"
    strUserLname = "\(dict["user_lname"] ?? "")"
    strBusinessName = "\(dict["business_name"] ?? "")"
    strUserPhone = "\(dict["user_phone"] ?? "")"
    strUserLocation = "\(dict["user_location"] ?? "")"
    strCity  = "\(dict["city"] ?? "")"
    strCategoryService = "\(dict["category_service"] ?? "")"
    strImages = "\(dict["images"] ?? "")"
    strWorkingHours = "\(dict["working_hours"] ?? "")"
    strWhFrom = "\(dict["wh_from"] ?? "")"
    strWhTo = "\(dict["wh_to"] ?? "")"
    strUserEmail = "\(dict["user_email"] ?? "")"
    strUserPassword = "\(dict["user_password"] ?? "")"
    strUserAvatar = "\(dict["user_avatar"] ?? "")"
    strLatitude = "\(dict["latitude"] ?? "")"
    strLongitude = "\(dict["longitude"] ?? "")"
    strRole = "\(dict["role"] ?? "")"
    strOhCurrentNotes = "\(dict["oh_current_notes"] ?? "")"
    strUserToken = "\(dict["user_token"] ?? "")"
    strUserType = "\(dict["user_type"] ?? "")"
    strSubscription = "\(dict["subscription" ?? ""])"
    
    }
}

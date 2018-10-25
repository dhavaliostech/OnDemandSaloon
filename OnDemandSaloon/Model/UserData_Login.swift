//
//  UserData_Login.swift
//  OnDemandSaloon
//
//  Created by PS on 11/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class UserData_Login: NSObject {
  
    var strUserId:String!
    var strUserFName:String!
    var strUserLName:String!
    var strBusinessName:String!
    var strUserPhone:String!
    var strUserLoaction:String!
    var strCity:String!
    var strCategoryService:String!
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
    
    init(dict:[String:Any]) {
        strUserId = "\(dict["id"] ?? "")"
        strUserFName = "\(dict["user_fname"] ?? "")"
        strUserLName = "\(dict["user_lname"] ?? "")"
        strBusinessName = "\(dict["business_name"] ?? "")"
        strUserPhone = "\(dict["user_phone"] ?? "")"
        strUserLoaction = "\(dict["user_location"] ?? "")"
        strCity = "\(dict["city"] ?? "")"
        strCategoryService = "\(dict["category_service"] ?? "")"
        strWorkingHours = "\(dict["working_hours"] ?? "")"
        strWhFrom = "\(dict["wh_from"] ?? "")"
        strWhTo = "\(dict["wh_to"] ?? "")"
        strUserEmail = "\(dict["user_email"] ?? "")"
        strUserPassword = "\(dict["user_password"] ?? "")"
        strUserAvatar = "\(dict["user_avatar"] ?? "")"
        strLatitude = "\(dict["latitude"] ?? "")"
        strLongitude = "\(dict["longitude"] ?? "")"
        strRole = "\(dict["role"] ?? "")"
        strStatus = "\(dict["status"] ?? "")"
        strOhCurrentNotes = "\(dict["oh_current_notes"] ?? "")"
        strUserToken = "\(dict["user_token"] ?? "")"
    }
    
}

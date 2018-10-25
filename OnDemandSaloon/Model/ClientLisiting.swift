//
//  ClientLisiting.swift
//  WhatsappDemo
//
//  Created by Saavaj on 14/08/18.
//  Copyright © 2018 Saavaj. All rights reserved.
//

import UIKit

class ClientLisiting: NSObject {
    
    var strClId:String!
    var strClFname:String!
    var strClLName:String!
    var strClPhone:String!
    var strClEmail:String!
    var strClBirthday:String!
    var strClNotes:String!
    var strClStreet:String!
    var strClCity:String!
    var strClPostcode:String!
    var strClImage:String!
    var strClAddBy:String!
    var strClStatus:String!
    var strClProviderID:String!
    var stClProviderRole:String!
    
    init(dict:[String:Any]){

        strClId = "\(dict["cl_id"] ?? "")"
        strClFname = "\(dict["cl_fname"] ?? "")"
        strClLName = "\(dict["cl_lname"] ?? "")"
        strClPhone = "\(dict["cl_phone"] ?? "")"
        strClEmail = "\(dict["cl_email"] ?? "")"
        strClBirthday = "\(dict["cl_birthday"] ?? "")"
        strClNotes = "\(dict["cl_notes"] ?? "")"
        strClStreet = "\(dict["cl_street"] ?? "")"
        strClCity = "\(dict["cl_city"] ?? "")"
        strClPostcode = "\(dict["cl_postcode"] ?? "")"
        strClImage = "\(dict["cl_image"] ?? "")"
        strClAddBy = "\(dict["cl_added_by"] ?? "")"
        strClStatus = "\(dict["cl_status"] ?? "")"
        strClProviderID = "\(dict["cl_provider_id"] ?? "")"
        stClProviderRole = "\(dict["cl_provider_role"] ?? "")"
    }
}

//
//  AddOffersData.swift
//  OnDemandSaloon
//
//  Created by Saavaj on 07/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class AddOffersData: NSObject {

    var strOffId:String!
    var strOffName:String!
    var strOffDesc:String!
    var strOffStartDate:String!
    var strOffEndDate:String!
    var strOffServiceId:String!
    var strOffStatus:String!
    
    init(dict:[String:Any]){
        
        strOffId = "\(dict["off_id"] ?? "")"
        strOffName = "\(dict["off_name"] ?? "")"
        strOffDesc = "\(dict["off_desc"] ?? "")"
        strOffStartDate = "\(dict["off_start_date"] ?? "")"
        strOffEndDate = "\(dict["off_end_date"] ?? "")"
        strOffServiceId = "\(dict["off_services_id"] ?? "")"
        strOffStatus = "\(dict["off_status"] ?? "")"
    }
}

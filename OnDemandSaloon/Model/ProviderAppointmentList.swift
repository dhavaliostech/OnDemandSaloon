//
//  ProviderAppointmentList.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 14/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class ProviderAppointmentList: NSObject {

    var strId :String!
    var strFName :String!
    var strLName :String!
    var strServiceName :String!
    var strPrice :String!
    var strDate :String!
    var strParentServiceId :String!
    var strServiceTime :String!
    var strServiceProId :String!
    var strUserId :String!
    var strStatus :String!
    var strCreatedTime :String!
    
    init(dict:[String:Any]){
        
        strId = "\(dict["app_id"] ?? "")"
        strFName = "\(dict["app_fname"] ?? "")"
        strLName = "\(dict["app_lname"] ?? "")"
        strServiceName = "\(dict["app_service_name"] ?? "")"
        strPrice = "\(dict["app_price"] ?? "")"
        strDate = "\(dict["app_date"] ?? "")"
        strParentServiceId = "\(dict["app_parent_serv_id"] ?? "")"
        strServiceTime = "\(dict["app_service_time"] ?? "")"
        strServiceProId = "\(dict["app_service_pro_id"] ?? "")"
        strUserId = "\(dict["app_user_id"] ?? "")"
        strStatus = "\(dict["app_status"] ?? "")"
        strCreatedTime = "\(dict["app_created_time"] ?? "")"
        
    }
}

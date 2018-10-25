//
//  GetAllNotifications.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 20/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class GetAllNotifications: NSObject {

    var strNotification_text:String!
    var created_date:String!
    var not_id:String!
    var not_provider_id:String!
    var business_name:String!
    var user_avatar:String!
    
    
    init(dict:[String:Any]) {
        
        strNotification_text = "\(dict["notification_text"] ?? "")"
        created_date = "\(dict["created_date"] ?? "")"
        not_id = "\(dict["not_id"] ?? "")"
        not_provider_id = "\(dict["not_provider_id"] ?? "")"
        business_name = "\(dict["business_name"] ?? "")"
        user_avatar = "\(dict["user_avatar"] ?? "")"
        
    }
    
}

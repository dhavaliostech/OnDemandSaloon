//
//  WorkingDayHours.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 01/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class WorkingDayHours: NSObject {

    var day :String!
    var startTime:String!
    var endTime:String!
    
    init(w_day:String,sTime:String,eTime:String) {
        
        day = w_day
        startTime = sTime
        endTime = eTime
        
    }
    
}

class MyOpeningHours:NSObject{
    
    var oh_day:String!
    var oh_from_time:String!
    var oh_to_time:String!
    var oh_provider_id:String!
    
    
    init(dict:[String:Any]) {
        
        oh_day = "\(dict["oh_day"] ?? "")"
        oh_from_time = "\(dict["oh_from_time"] ?? "")"
        oh_to_time = "\(dict["oh_to_time"] ?? "")"
        oh_provider_id = "\(dict["oh_provider_id"] ?? "")"
    }
    
}

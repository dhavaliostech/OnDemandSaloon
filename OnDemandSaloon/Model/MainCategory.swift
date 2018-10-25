//
//  MainCategory.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 27/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class MainCategory: NSObject {

    var ser_id :String!
    var ser_name :String!
    var service_data :[ServiceDetails] = []
    
    init(dict:[String:Any]){
        ser_id = "\(dict["ser_id"] ?? "")"
        ser_name = "\(dict["ser_name"] ?? "")"
        
        if let getData = dict["service_data"] as? [[String:Any]] {
            
            for i in getData{
                self.service_data.append(ServiceDetails(dict: i))
            }
            
        }
    }
    
}

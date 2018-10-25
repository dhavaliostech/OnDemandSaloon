//
//  DashBoard.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 05/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class DashBoard: NSObject {

    var daily_progress:String!
    var total_revenue:String!
    var total_appointments:String!
    var total_clients:String!
    var provider_id:String!
    
    init(dict:[String:Any]) {
        
        daily_progress = "\(dict["daily_progress"] ?? "")"
        total_revenue = "\(dict["total_revenue"] ?? "")"
        total_appointments = "\(dict["total_appointments"] ?? "")"
        total_clients = "\(dict["total_clients"] ?? "")"
        provider_id = "\(dict["provider_id"] ?? "")"
    }
    
}

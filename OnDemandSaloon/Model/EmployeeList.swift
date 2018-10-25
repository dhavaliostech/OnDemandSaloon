//
//  EmployeeList.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 15/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class EmployeeList: NSObject {
 
    var emId : String!
    var emFName:String!
    var emLName:String!
    var emPhone : String!
    var emEmail : String!
    var emBirthday : String!
    
    var emImage : String!
    var emAddeddBy : String!
    var emStatus : String!
    var emStreet :String!
    
    
    var emTime : [EmployeeTime] = []
    var emServices :[EmployeeServices] = []

    init (dict:[String:Any]){
        
        emId = "\(dict["em_id"] ?? "")"
        emFName = "\(dict["em_fname"] ?? "")"
        emLName = "\(dict["em_lname"] ?? "")"
        emPhone = "\(dict["em_phone"] ?? "")"
        emEmail = "\(dict["em_email"] ?? "")"
        emBirthday = "\(dict["em_birthday"] ?? "")"
        
        
        emImage = "\(dict["em_image"] ?? "")"
        emAddeddBy = "\(dict["em_added_by"] ?? "")"
        emStatus = "\(dict["em_status"] ?? "")"
        emStreet = "\(dict["em_street"] ?? "")"
        if let getService = dict["service_list"] as? [[String:Any]]{
            
            for i in getService{
                emServices.append(EmployeeServices(dict: i))
            }
            
        }
        
        if let getWorking = dict["time_list"] as? [[String:Any]]{
            
            for i in getWorking{
                emTime.append(EmployeeTime(dict: i))
            }
            
        }
        
       
    }
    
}

class EmployeeServices:NSObject{
    
    var ser_id :String!
    var ser_name :String!
    var emp_cat_parent_id :String!
    
    init(dict:[String:Any]) {
        
        ser_id = "\(dict["ser_id"] ?? "")"
        ser_name = "\(dict["ser_name"] ?? "")"
        emp_cat_parent_id = "\(dict["emp_cat_parent_id"] ?? "")"
    }
    
}

class EmployeeTime:NSObject{
    
    var emp_oh_id:String!
    var emp_oh_day:String!
    var emp_oh_start_time:String!
    var emp_oh_end_time:String!
    
    init(dict:[String:Any]) {
        
        emp_oh_id = "\(dict["emp_oh_id"] ?? "")"
        emp_oh_day = "\(dict["emp_oh_day"] ?? "")"
        emp_oh_start_time = "\(dict["emp_oh_start_time"] ?? "")"
        emp_oh_end_time = "\(dict["emp_oh_end_time"] ?? "")"
    }
    
}

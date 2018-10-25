//
//  AccountSettings.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 05/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class AccountSettings: NSObject {

    var que_id:String!
    var que_name:String!
    var answer_list:[QuestionAns] = []
    
    init(dict:[String:Any]) {
        que_id = "\(dict["que_id"] ?? "")"
        que_name = "\(dict["que_name"] ?? "")"
        
        if let getList = dict["answer_list"] as? [[String:Any]]{
            for i in getList{
                answer_list.append(QuestionAns(dict: i))
            }
            
        }
        
    }
    
}


class QuestionAns: NSObject {

    var ans_id:String!
    var answer_name:String!
    var answer_que_id:String!
    
    init(dict:[String:Any]) {
        
        ans_id = "\(dict["ans_id"] ?? "")"
        answer_name = "\(dict["answer_list"] ?? "")"
        answer_que_id = "\(dict["answer_que_id"] ?? "")"
    
    }
    
}

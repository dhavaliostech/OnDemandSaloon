//
//  NotificationData.swift
//  OnDemandSaloon
//
//  Created by PS on 06/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class NotificationData: NSObject {

    
    var strSetQueId:String!
    var strSetQueName:String!
    var anserList:[Anserlist] = []
    
    
    init(dict:[String:Any]){
        
        strSetQueId = "\(dict["set_que_id"] ?? "")"
        strSetQueName = "\(dict["set_que_name"] ?? "")"
        
        
        
        if let getObj = dict["answer_list"] as? [[String:Any]]{
            
            for i in getObj{
                anserList.append(Anserlist(dict: i))
            }
            
        }
        
       
        
    }
}

class Anserlist :NSObject{
    
    var strSetAnsId:String!
    var strSetAnswerList:String!
    var strSetAnswerQueId:String!
    
    init(dict:[String:Any]){
        
        strSetAnsId = "\(dict["set_ans_id"] ?? "")"
        strSetAnswerList = "\(dict["set_answer_list"] ?? "")"
        strSetAnswerQueId = "\(dict["set_answer_que_id"] ?? "")"
    }
}

class SelectedQuestionData:NSObject{
    
    var bookingReminder:String!
    var nearByProxymity:String!
    
    init(dict:[String:Any]) {
        
        bookingReminder = "\(dict["booking_remainder"] ?? "")"
        nearByProxymity = "\(dict["near_by_proximity"] ?? "")"
    }
    
}

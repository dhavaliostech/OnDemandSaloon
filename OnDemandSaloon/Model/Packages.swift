//
//  Packages.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 28/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class Packages: NSObject {

    var advance:Advance!
    var standard:Standard!
    var premier:Premier!
    
    init (dict:[String:Any]){
        
        if let getData = dict["Advance"] as?[String:Any]{
            advance = Advance(dict: getData)
        }
        
        if let getData = dict["Standard"] as?[String:Any]{
            standard = Standard(dict: getData)
        }
        
        if let getData = dict["Premier"] as?[String:Any]{
            premier = Premier(dict: getData)
        }     
    }

}

class Advance:NSObject{
    var pack_id:String!
    var pack_name:String!
    var pack_desc:String!
    var pack_price:String!
    
    init(dict:[String:Any]) {
        
        pack_id = "\(dict["pack_id"] ?? "")"
        pack_name = "\(dict["pack_name"] ?? "")"
        pack_desc = "\(dict["pack_desc"] ?? "")"
        pack_price = "\(dict["pack_price"] ?? "")"
    }
 
}

class Standard:NSObject{
    
    var pack_id:String!
    var pack_name:String!
    var pack_desc:String!
    var pack_price:String!
    
    init(dict:[String:Any]) {
        
        pack_id = "\(dict["pack_id"] ?? "")"
        pack_name = "\(dict["pack_name"] ?? "")"
        pack_desc = "\(dict["pack_desc"] ?? "")"
        pack_price = "\(dict["pack_price"] ?? "")"
    }
    
}
class Premier:NSObject{
    
    var pack_id:String!
    var pack_name:String!
    var pack_desc:String!
    var pack_price:String!
    
    init(dict:[String:Any]) {
        
        pack_id = "\(dict["pack_id"] ?? "")"
        pack_name = "\(dict["pack_name"] ?? "")"
        pack_desc = "\(dict["pack_desc"] ?? "")"
        pack_price = "\(dict["pack_price"] ?? "")"
    
    }
    
}

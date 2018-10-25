//
//  testObject.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 07/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class TestObject: NSObject {

    var strServices:String!
    var serviceImage:UIImage!
    
    init(service:String?,img:UIImage?){
        
        strServices = service
        serviceImage = img
        
    }
    
}

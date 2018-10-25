//
//  GetSearchData.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 27/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class GetSearchData: NSObject {
   
    var cityArray:[GetCities] = []
    var contryArray : [GetContry] = []
    var locationArray :[GetLocation] = []
    var getAllTheCategories:[MainCategory] = []
    
    var minValue:String!
    var maxValue:String!
    
    init(dict:[String:Any]){
        
        if let getData = dict["country_data"] as? [[String:Any]]{
            
            for i in getData{
                self.contryArray.append(GetContry(dict: i as! [String:Any]))
            }
            
        }
        
        if let getData = dict["city_data"] as? [[String:Any]]{
            
            for i in getData{
                self.cityArray.append(GetCities(dict: i))
            }
        }
        
        if let getData = dict["location_data"] as? [[String:Any]]{
            
            for i in getData{
                self.locationArray.append(GetLocation(dict: i))
            }
        }
        
        if let getData = dict["category_data"] as? [[String:Any]]{
            
            for i in getData{
                self.getAllTheCategories.append(MainCategory(dict: i))
            }
        }
        
        minValue = "\(dict["min_price"] ?? "")"
        maxValue = "\(dict["max_price"] ?? "")"
        
    }
    
}

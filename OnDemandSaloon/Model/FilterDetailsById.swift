//
//  FilterDetailsById.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 22/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class FilterDetailsById: NSObject {

    var contry : [GetContry] = []
    var cities:[GetCities] = []
    var location:[GetLocation] = []
    var categorySerViceDetails:[ServiceDetails] = []
   
    var mainObjectForSalon : [SalonObj] = []
    
    init(dict:[String:Any]) {
        
        if let getObj = dict["countries"] as? [[String:Any]]{
            
            for i in getObj{
                contry.append(GetContry(dict: i))
            }
            
        }
        if let getObj = dict["cities"] as? [[String:Any]]{
            
            for i in getObj{
                cities.append(GetCities(dict: i))
            }
            
        }
        
         if let getObj = dict["Location"] as? [[String:Any]]{
            
            for i in getObj{
                location.append(GetLocation(dict: i))
            }
            
        }
        
         if let getObj = dict["category_services_details"] as? [[String:Any]]{
            
            for i in getObj{
                categorySerViceDetails.append(ServiceDetails(dict: i))
            }
            
        }
  
         if let getOBj = dict["shops_details"] as? [[String:Any]]{
            for i in getOBj{
                
                mainObjectForSalon.append(SalonObj(dict: i))
               
            }
        }
        
    }
    
}

class GetContry:NSObject{
    var contry_id :String!
    var contry_Name:String!
    
    init(dict:[String:Any]){
        contry_id = "\(dict["id"] ?? "")"
        contry_Name = "\(dict["country_name"] ?? "")"
    }
}

class GetCities:NSObject{
    var city_id :String!
    var cityName:String!
    
    init(dict:[String:Any]){
        city_id = "\(dict["id"] ?? "")"
        cityName = "\(dict["city_name"] ?? "")"
    }
}

class GetLocation:NSObject{
    var loc_ID :String!
    var locName:String!
    var city_ID:String!
    
    init(dict:[String:Any]){
        loc_ID = "\(dict["loc_id"] ?? "")"
        locName = "\(dict["loc_name"] ?? "")"
        city_ID = "\(dict["city_id"] ?? "")"
    }
}

class ServiceDetails: NSObject{

    var ser_cat_ID:String!
    var ser_cat_Name:String!
    var ser_cat_Parent:String!

    init(dict:[String:Any]) {

        ser_cat_ID =  "\(dict["ser_cat_id"] ?? "")"
        ser_cat_Name =  "\(dict["ser_cat_name"] ?? "")"
        ser_cat_Parent =  "\(dict["ser_cat_parent"] ?? "")"
    }
}

class SalonObj:NSObject{
    
    var id :String!
    var business_name :String!
    var user_location :String!
    var city :String!
    var sp_cat_id :String!
    var banner_name :String!
    var rat_out_of_5 :String!
    var total_review :String!
    var happy_performance :String!
    var salon_min_price :String!
    var salon_max_price :String!
    var providerID :String!
    var salonSubCatServices:[SalonSubCat] = []
    
    init(dict:[String:Any]) {

        id = "\(dict["id"] ?? "")"
        business_name = "\(dict["business_name"] ?? "")"
        user_location = "\(dict["user_location"] ?? "")"
        city = "\(dict["city"] ?? "")"
        banner_name = "\(dict["banner_name"] ?? "")"
        sp_cat_id = "\(dict["sp_cat_id"] ?? "")"
        providerID = "\(dict["ser_cs_provider_id"] ?? "")"
        rat_out_of_5 = "\(dict["rat_out_of_5"] ?? "")"
        total_review = "\(dict["total_review"] as! String)"
        happy_performance = "\(dict["happy_performance"] ?? "")"
        salon_min_price = "\(dict["salon_min_price"] ?? "")"
        salon_max_price = "\(dict["salon_max_price"] ?? "")"
        
        if let getOBJ = dict["salon_sub_category_services"] as? [[String:Any]]{
            
            for i in getOBJ{
                salonSubCatServices.append(SalonSubCat(dict: i))
            }
        }
    }
}

class SalonSubCat:NSObject{
    
    var ser_cs_ID:String!
    var ser_cs_Name:String!

    init(dict:[String:Any]){
        ser_cs_ID = "\(dict["ser_cs_id"] ?? "")"
        ser_cs_Name = "\(dict["ser_cs_name"] ?? "")"
    }
}

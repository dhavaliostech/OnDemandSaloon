//
//  ProviderProfile.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 05/09/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class ProviderProfile: NSObject {

    var proID :String!
    var business_name :String!
    var pro_phone :String!
    var pro_location :String!
    var pro_avatar :String!
    var city :String!
    var country :String!
    var business_full_address :String!
    var role :String!
    var pro_email :String!
    var bannerImageArray :[BannerImage] = []
    
    init(dict:[String:Any]) {
        
        proID = "\(dict["id"] ?? "")"
        business_name = "\(dict["business_name"] ?? "")"
        pro_phone = "\(dict["user_phone"] ?? "")"
        pro_location = "\(dict["user_location"] ?? "")"
        pro_avatar = "\(dict["user_avatar"] ?? "")"
        pro_email = "\(dict["user_email"] ?? "")"
        city = "\(dict["city"] ?? "")"
        country = "\(dict["country"] ?? "")"
        business_full_address = "\(dict["business_full_address"] ?? "")"
        role = "\(dict["role"] ?? "")"
        //
        if let getListOfimage = dict["banner_images"] as? [[String:Any]] {
            
            for i in getListOfimage{
                
                bannerImageArray.append(BannerImage(dict: i))
            }
            
        }
        
    }
    
}

class BannerImage:NSObject{
    
    var banner_id :String!
    var bannerName:String!
    var strProviderId:String!
    init(dict:[String:Any]) {
        
        banner_id = "\(dict["banner_id"] ?? "")"
        bannerName = "\(dict["banner_name"] ?? "")"
        strProviderId = "\(dict["provider_id"] ?? "")"
    }
    
}



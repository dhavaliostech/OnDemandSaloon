//
//  Filter.swift
//  OnDemandSaloon
//
//  Created by Macbook Pro on 29/08/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class RetriveDataOfBookService: NSObject {

    var mainArray:[CatSerDetails] = []
    var mainCatID:String!
    
    init(addoBj:CatSerDetails,id:String) {

        mainArray.append(addoBj)
        mainCatID = id

    }
}





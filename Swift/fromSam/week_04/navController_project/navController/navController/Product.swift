//
//  Product.swift
//  navController
//
//  Created by FT_MacBookPro on 2/19/15.
//  Copyright (c) 2015 FTslo. All rights reserved.
//

import Foundation

class Product {
    // company will be an Int b/c it'll be an index of an array
    var companyId:Int?
    var name:String?
    var id:Int?
    
    init(id:Int, name:String){
        self.id = id
        self.name = name
    }
}
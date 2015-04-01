//
//  Product.swift
//  navCtrl
//
//  Created by Aditya Narayan on 2/19/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

import Foundation

class Product {
    var id:Int
    var name:String
    var companyId:Int?
    
    init(id:Int, name:String){
        self.id = id;
        self.name = name
    }
}

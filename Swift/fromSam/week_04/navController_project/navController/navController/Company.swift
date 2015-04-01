//
//  Company.swift
//  navController
//
//  Created by FT_MacBookPro on 2/19/15.
//  Copyright (c) 2015 FTslo. All rights reserved.
//

import Foundation

class Company {
    var companyId:Int?
    var name:String?
//    var products:Array = [Product]()          //typing products as an Array won't compile in line 84 of DataInit Class
//    var products:[AnyObject] = [Product]()    // typed as an Array that holds AnyObject works
    var products = [Product]()                  // instead don't type the var, and allow Swift to deduce the correct type
    var image:String?
    var stockPrice:String?
    
    init(){}
    
}
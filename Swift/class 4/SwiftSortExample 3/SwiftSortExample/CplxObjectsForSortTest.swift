//
//  CplxObjectsForSortTest.swift
//  FirstApp
//
//  Created by Aditya Narayan on 6/10/14.
//  Copyright (c) 2014 QCD Systems. All rights reserved.
//

import Foundation

class Employee {
    
    
    var name:String?
    
    init(var s:String) {
        
        self.name = s
    }
    
    func getName() -> String {
        
        return name!
        
    }
    
}
//
//  SimpleClass.swift
//  Class5_MemoryManagement
//
//  Created by Aditya Narayan on 7/28/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

import Foundation


class SimpleClass {
    
    
    var simpleClassId:Int
    
    init ( var id:Int) {
        
        self.simpleClassId = id
        
    }
    
    deinit {
        
//        println("Deinitializing class id = \(simpleClassId)")
        println("my last wish = \(simpleClassId)")
        
    }
    
    
    
    
}

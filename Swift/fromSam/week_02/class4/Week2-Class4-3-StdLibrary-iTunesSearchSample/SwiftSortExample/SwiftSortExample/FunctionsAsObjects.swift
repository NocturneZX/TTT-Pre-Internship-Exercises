//
//  FunctionsAsObjects.swift
//  SwiftSortExample
//
//  Created by Aditya Narayan on 6/10/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

import Foundation


func functionWithACounter() -> (() -> ()) {
    
    var counter = 1
    
    
    func implementSomeAlternatingBehavior() {

        
        var s:Bool
        
        s = false
        
        if counter % 2 == 0 {
            
            println("This function was called an EVEN number of times")
            
        } else {
            
            println("This function was called an ODD number of times")
            
        }
        counter++
    }
    return implementSomeAlternatingBehavior
    
}
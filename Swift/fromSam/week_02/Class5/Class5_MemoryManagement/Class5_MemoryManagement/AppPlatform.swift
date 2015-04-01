//
//  AppPlatform.swift
//  Class5_MemoryManagement
//
//  Created by Aditya Narayan on 7/28/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

import Foundation


class AppPlatform {
    
    
    var pfName:String   //ios
    
//     var languageSupported:AppProgrammingLanguage     // swift
    
    unowned var languageSupported:AppProgrammingLanguage    // unowned says, it needs but doesn't own it

    
    init(platformName:String, language:AppProgrammingLanguage) {
        
        self.pfName = platformName

        self.languageSupported = language        
        
    }
    
    deinit {
        
        println("Deinitializing obj for platform = \(pfName)")
        
        
    }
  
    
}
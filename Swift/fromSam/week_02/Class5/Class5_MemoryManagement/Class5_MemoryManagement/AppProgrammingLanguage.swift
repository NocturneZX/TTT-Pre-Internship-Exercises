//
//  AppProgrammingLanguage.swift
//  Class5_MemoryManagement
//
//  Created by Aditya Narayan on 7/28/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

import Foundation

class AppProgrammingLanguage {
    
    
    var languageName:String
    
    var applicableToPlatform:AppPlatform?
    
    init(progLangName:String, platform:AppPlatform?) {
        
        self.languageName = progLangName
        
        self.applicableToPlatform = platform
        
    }
    
    deinit {
        
        println("Deinitializing obj for platform = \(applicableToPlatform)")
        println("Deinitializing obj for language = \(languageName)")
        
    }

    
}

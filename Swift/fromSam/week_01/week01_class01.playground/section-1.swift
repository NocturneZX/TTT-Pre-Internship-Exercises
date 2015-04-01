// Playground - noun: a place where people can play

import UIKit

func functionWithACounter() -> (() ->()) {
    
    var counter = 1
    
    func implementSomeAlternatingBehavior() {
        
//        var s:Bool
//        
//        s = false
        
        if counter % 2 == 0 {
            
            println("This function was called an EVEN number of times")

        } else {
            
            println("This function was called on ODD number of times")
            
        }
        
        counter++
        
    }
    
    return implementSomeAlternatingBehavior
    // this is not a function call, it's a reference to the block of code.. the area of memory where the block of code is sitting
}

var assignedVar = functionWithACounter


// assignedVar is actually the inner function, but it has remembered the local variable 'counter' in the outer function .. instead of using a global variable

// real world example.. if you wanna download data from itunes and this data is large.. ie: list of albums of an artist in the last 5 years you wouldn't want your user to be waiting for that list to download for 5 minutes.. the download should happen in the background.. they hit a button, they get a message that the things downloading, and they get notified of it when it's done.. sequential stuff freezes.

// itunes search example

func search(searchArg) -> (()->()) {
    
    var searchTerm = searchArg
    
    func triggerSearch() {
     
        //
    }
    func searchComplete() {
        // result = ...
    }
    
    
}


//
//  ViewController.swift
//  Class5_MemoryManagement
//
//  Created by Aditya Narayan on 7/28/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    //------- Declare instance vars -----
    
    //-----------------------------------
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //----- Declare all references to UI elements -----------
    
    
    @IBOutlet var numSimpleObjectsToCreateTF : UITextField!
    
    
    @IBOutlet var numSimpleObjsLabel : UILabel!
    
    //----- END: Declare all references to UI elements ------

    
    //---- START: Stage 1 - Simple object demo ------------------------
    
    
    //Instance var
    var singleObj:SimpleClass?
    
    @IBOutlet var objCount : UILabel!
    
    @IBAction func createSimpleObject() {
        
        //Local variable
        
        //var singleObj:SimpleClass?
        
        
        println("\n\n------------------------Stage 1 - Simple object demo------------------------")
        
        singleObj = SimpleClass(id:10000)
        
        //singleObj = nil
        
        //singleObj = SimpleClass(id:10001)
        
        
        println("\nLast Line in function \n\n")
        
    }
    
    
    @IBAction func releaseSimpleObject() {
        
        self.singleObj = nil    // self is clearly demonstrating that this is an Instance variable of the class, not a local variable, also not to somehow accidentally reference a global variable  //        var am = "am"  // would be a local variable in this method

        
        println("\n\nTried to release simple object. deinit must be called\n\n")
        
    }
    
    //---- END: Stage 1 - Simple object demo ------------------------
    
    
    
    //---- START: Stage 2 - Simple object demo ------------------------
    
    
    var simpleObjArray = [SimpleClass]()
    
    //var simpleObjArray:[SimpleClass]?

    
    @IBAction func createSimpleObjects() {
        
        println("\n\n------------------------Stage 2 - Simple object demo------------------------")
        
        var numObjects:Int?
       
        
        numObjects = self.numSimpleObjectsToCreateTF.text.toInt()
        
        for var i = 0; i < numObjects; i++ {
            
            
            var myObj:SimpleClass =  SimpleClass(id:i)  // this goes out of scope after this func is completed, but...
            
            self.simpleObjArray.append(myObj)    // it's appended to the array and the reference to the array is still in scope
            
        }
        
        self.numSimpleObjsLabel.text = "\(simpleObjArray.count)"
        
        println("\n\n Created \(simpleObjArray.count) simple objects\n\n")
        
    }
    
    
    @IBAction func releaseSimpleObjRefs() {
        
        
//        for var i = 0; i < simpleObjArray.count; i++ {
//            
//            var myObj:SimpleClass? = simpleObjArray[i]
//            
//            var id = myObj!.simpleClassId
//            
//            myObj = nil
//            
//        }

        println("\n\nCalling removeAll on array with \(simpleObjArray.count) elements, individual elements will get deallocated now ...\n\n")

        
       self.simpleObjArray.removeAll(keepCapacity: false)
        
        //self.simpleObjArray = nil
        
 //       self.numSimpleObjsLabel.text = "\(simpleObjArray.count)"
        
        
    }
    
    @IBAction func getNumSimpleObjects() {
        
        self.numSimpleObjsLabel.text = "\(simpleObjArray.count)"
        
    }
    
    
    //---- END: Stage 2 - Simple object demo ------------------------
    
    
    
    //---- START: Stage 3 - Strong retain cycle demo ------------------------
    
    
    var strongRetainDemoObjArrayOfAppPlatforms = [AppPlatform]()
    
    var myLang:AppProgrammingLanguage?
    var myPf:AppPlatform?

    
    @IBAction func createObjectsForStrongRetainCycleDemo() {
        
            println("\n\n------------------------Stage 3 - Strong retain cycle demo------------------------")
        
//            var myLang:AppProgrammingLanguage?
//            var myPf:AppPlatform?
        
            //Create objects with a strong retain cycle
        
            myLang = AppProgrammingLanguage(progLangName: "C#", platform: nil)
            myPf =  AppPlatform(platformName: "Windows Phone", language: myLang!)
        
            myLang!.applicableToPlatform = myPf
        
            println("\n\nInstance variables for Windows and C# created ...\n\n")
        
        
    }
    
    
    @IBAction func releaseObjectsForStrongRetainDemo() {
        
        
        //Note: Once this method exits, the two object references are no longer needed. Do the objects get deinitialized?
        
        //Task 1: Uncomment the following to explicitly set them to nil. What happens?
        myPf = nil
        
        myLang = nil
       

        println("\n\nTried to release cross-referenced objects. deinit must be called\n\n")
        
    }
    
    //---- END: Stage 3 - Strong retain cycle demo ------------------------
    
    
    //---- START: Stage 4 - Strong retain cycle demo ----------------------
    
    
    @IBAction func createObjectsThatGoOutOfScope() {
        
        //Create objects with a strong retain cycle
        
        println("\n\n------------------------Stage 4 - Strong retain cycle demo------------------------")
        
        var myLang:AppProgrammingLanguage = AppProgrammingLanguage(progLangName: "Java", platform: nil)
        var myPf:AppPlatform =  AppPlatform(platformName: "Android", language: myLang)
        
        myLang.applicableToPlatform = myPf
        
        println("\n\nLocal variables for Android and Java created ...\n\n")
        
        println("\n\nLocal variables going out of scope now ...\n\n")
        
    }
    
    //---- END: Stage 4 - Strong retain cycle demo ------------------------
    
    
}

// slo notes
// w/o ARC (automatic reference counting - similar to garbage collection) an OBJECT that is created and is no longer in scope would be a memory leak and you have no way of accessing it eating up RAM, different for primitives
// HEAP and STACK - two types of memory
// anytime you create an object, it goes on the HEAP
// local variables of functions - simple data - goes on the STACK - after the function is done and out of scope, it is automatically cleaned up - doesn't need to involve ARC

func callAnotherFunction() {
    
    testScope() // when this is run, the vars/objects are in scope and in memory

    // after this point, it is no longer in scope but it is still in RAM - so if not for ARC, it would be memory leak
}

func testScope() {
    
    var myNumber = 100 // primitive? - or simple piece of data
    
    var someObject = SimpleClass(id:10000) // after func finishes, and goes out of scope, this will be cleaned up by arc
    
    println()
}

// Cross references A references B, B references A, if A goes out of scope B needs it it goes to a loop of codependency - this should be avoided, here's the example









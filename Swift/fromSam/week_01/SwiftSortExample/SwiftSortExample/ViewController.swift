//
//  ViewController.swift
//  SwiftSortExample
//
//  Created by Aditya Narayan on 6/10/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

import UIKit

import Foundation

class ViewController: UIViewController {
    
    
    

    
    var altFunction:(() -> ())?
    var altFunction2:(() -> ())?
    

    //--------- Functions as closures -------
    
    @IBAction func functionAsObjDemo() {
        
        println("-------- START: Simple function as closure -------")
        
        
//        if !(altFunction != nil) {
        if (altFunction == nil) {
        
            altFunction = functionWithACounter()
                // this is created only once b/c not nil
        
        }
        if (altFunction2 == nil) {
            
            altFunction2 = functionWithACounter()
            // this is created only once b/c not nil
            
        }
        
        altFunction!()// the ! is b/c it can be a nil value
        altFunction2!()// the ! is b/c it can be a nil value
        altFunction!()// the ! is b/c it can be a nil value
        
        // prints ODD ODD EVEN b/c they have independent counters
        
        println("-------- END: Simple function as closure -------")
        
    }
    
    
    //--------- End Functions as objects -------
    
    
    //-------- Simple sort ----------------
    
    
    
  //-------- Pass closures as arguments to functions -------
    
    @IBAction func closuresAsArgs(sender : AnyObject) {
        
        println("-------- Pass closures as arguments to functions -------")
        
        var unsortedArray = ["A", "B", "P", "S"]
//        var unsortedArray = [15, 2, 12, 6]
        // this only compares the first two items, sorted
        // array.sorted { $0 < $1 } ascending order
        // array.sorted { $1 < $0 } descending order
        
        println(unsortedArray)
        
        var sortPrefClosureInline = {
            
            (s1:String, s2:String) -> Bool in
            println("  ")
            println("s1: \(s1) ,s2: \(s2)")
            if s1 > s2 {
                
                println("true s1: \(s1) ,s2: \(s2)")// 2, 1
                return true;
                
            } else {
                
                println("false s1: \(s1) ,s2: \(s2)")
                return false;
                
            }
            
        }
        var someBool = {
            
            (val2:Int, val1:Int) -> Bool in
            if val1 < val2 {
                
                println("true")
                return true;
                
            } else {
                
                println("false")
                return false;
                
            }
        }

        var sortedArray = sorted(unsortedArray, sortPrefClosureInline)
//        var sortedArray = sorted(unsortedArray, someBool)
        // false gives descending order
        // true gives ascending order

        println("Sorted: \(sortedArray)")
        
        println("-------- END: Pass closures as arguments to functions -------")
        
    }
    
    //---------- Create a closure on the fly ---------
    
    @IBAction func closuresOnTheFly(sender : AnyObject) {
        
        println("---------- START: Create a closure on the fly ---------")
        
        var unsortedArray = ["1", "2", "4", "3"]
        
        println(unsortedArray)
        
        var sortedArray = sorted(unsortedArray,{
            
            (s1:String, s2:String) -> Bool in
            
            if s1 > s2 {
                
                return true;
                
            } else {
                
                return false;
                
            }
            
            })

        var sortedArray2 = sorted(unsortedArray) {
            (s1:String, s2:String) -> Bool in
                if s1 > s2 {
                    return true;
                } else {
                    return false;
                }
            }
        
        var sortedArray3 = sorted(unsortedArray) {  $0 < $1 }


        
        
        
        println("Sorted: \(sortedArray3)")
        
        println("---------- END: Create a closure on the fly ---------")
        
        
    }
    
    //------ Closure as the last arg ------------
    
    
    @IBAction func closuresAsTheLastArg(sender : AnyObject) {
        
        println("---------- START: Closure as the last arg ---------")
        
        var unsortedArray = ["1", "2", "4", "3"]
        
        println(unsortedArray)
        
        var sortedArray = sorted(unsortedArray){
            
            (s1:String, s2:String) -> Bool in
            
            if s1 > s2 {
                
                return true;
                
            } else {
                
                return false;
                
            }
            
        }
        
        println("Sorted: \(sortedArray)")
        
        println("---------- END: Closure as the last arg ---------")
        
    }
    
    //------ Special closure notation ------
    
    @IBAction func specialClosureNotation(sender : AnyObject) {
        
        
        println("---------- START: Special closure notation ---------")
        
        var unsortedArray = ["1", "9", "4", "3"]
        
        println(unsortedArray)
        
        var sortedArray = sorted(unsortedArray){ $0 < $1 }
        
        println("Sorted: \(sortedArray)")
        
        println("---------- END: Special closure notation ---------")
        
    }
    
    
    //-------- End Simple sort ----------------
    
    
    
    
    
    
    //--------- 3.1 Algo demo ------------------------
    
    
    @IBAction func demoSimpleAlgos() {
        
        
        mapDemo()
        
    }
    
    
    
    //--------- End Algo demo ------------------------
    
    
    //-------- 3.2 Start Object sort ----------------
    
    @IBAction func complexSort(sender : AnyObject) {
        
        println("-------- START: Start Object sort ----------------")
        
        var o1 = Employee(s: "Matt")
        var o2 = Employee(s:"Justin")
        var o3 = Employee(s:"Indrajeet")
        var o4 = Employee(s:"Avi")
        
        var unsortedArray = [o1,o2,o3,o4]
        
        println("Unsorted array...")
        
        for obj in unsortedArray {
            
            var name = (obj as Employee).name
            
            println ( "obj name = \(name)")
        }

        
        var clo = { ($0 as Employee).getName() > ($1 as Employee).getName() }
        
        var sortedArray = sorted(unsortedArray,clo)
        
        println("\n\nSort complete...")
        
        for obj in sortedArray {
            
            var name = (obj as Employee).name
            
            println ( "obj name = \(name)")

            
        }
    
    
        println("-------- END: Start Object sort ----------------")
    
    }
    
    
    //-------- End Object sort ----------------
    
    
    //-------- 3.3 Async network calls ------------
    
    @IBOutlet var searchTextField : UITextField!
    
    
    @IBAction func startSearch() {
        
        
        asyncNetworkCall()
        
    }
    
    func asyncNetworkCall() {
        
        
        //1. Get search term
        var searchTerm:String = searchTextField.text
        

        //2. Create URL with HTTP Request
        let urlPath = "https://itunes.apple.com/search?term=\(searchTerm)&media=music&entity=album"
        
        println("iTunes GET REQUEST \n\n \(urlPath)\n\n")
        
        //3. Create connection object
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        //4. Make async call and declare 'closure on the fly' to accept the response whenever it is ready
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {//closure starts here
            
            (response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
            
            if (error != nil) {
                println("ERROR: \(error.localizedDescription)")
            }//if
            else {
                var jsonError: NSError?
                
                //5. Convert JSON to Dictionary
                let jsonResult: NSDictionary
                
                = NSJSONSerialization.JSONObjectWithData(data,
                                                options: NSJSONReadingOptions.MutableContainers,
                                                error: &jsonError) as NSDictionary
                
                
                // Now send the JSON result to our delegate object
                
                if (jsonError? != nil) {
                    println("JSON Error: \(jsonError?.localizedDescription)")
                }//if
                else {
                    
                    println("\n\n-------- Response from iTunes --------\n\n")
                    println(jsonResult)
                }//else
            }//else
        }//closure ends here
        
        println("Request sent to iTunes ....")
        
    }
    
    
    //-------- End Async network calls --------
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


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
    
    
    
    @IBOutlet var errorLabel: UILabel!

    var x:String?
    
    var altFunction:(() -> ())?
    

    //--------- Functions as closures -------
    
    var counter = 0
    
    func someAltFunction()  {
        
        
        
        counter++
        
        if counter % 2 == 0 {
            
            println("This function was called an EVEN number of times")
            
        } else {
            
            println("This function was called an ODD number of times")
            
        }
            
        
        
    }
    
    @IBAction func functionAsObjDemo() {
        
        println("-------- START: Simple function as closure -------")
        
        
        if !(altFunction != nil) {
        
        // Call functionWithACounter to get a ref to the counter function
        altFunction = functionWithACounter()
        
        }
        
        altFunction!()
        
//        someAltFunction()
        
        
        println("-------- END: Simple function as closure -------")
        
    }
    
    
    //--------- End Functions as objects -------
    
    
    //-------- Simple sort ----------------
    
    
    
  //-------- Pass closures as arguments to functions -------
    
    @IBAction func closuresAsArgs(sender : AnyObject) {
        
        println("-------- Pass closures as arguments to functions -------")
        
        var unsortedArray = ["Apple", "Microsoft", "Google", "Samsung","Apple"]
        
        println(unsortedArray)
        
        var sortPrefClosureInline = {
            
            (s1:String, s2:String) -> Bool in
            
            if s1 < s2 {
                
                return true;
                
            } else {
                
                return false;
                
            }
            
        }
        
        var sortedArray = sorted(unsortedArray, sortPrefClosureInline)

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

        
        println("Sorted: \(sortedArray)")
        
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
        
//        
//        println("---------- START: Special closure notation ---------")
//        
//        var unsortedArray = ["1", "2", "4", "3"]
//        
//        println(unsortedArray)
//        
//        var sortedArray = sorted(unsortedArray){ $0 > $1 }
//        
//        println("Sorted: \(sortedArray)")
//        
//        println("---------- END: Special closure notation ---------")
        
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
        
        var o1 = Sortable(s:"1")
        var o2 = Sortable(s:"2")
        var o3 = Sortable(s:"3")
        var o4 = Sortable(s:"4")
        
        var unsortedArray = [o1,o2,o3,o4]
        
        println("Unsorted array...")
        
        for obj in unsortedArray {
            
            var name = obj.name //(obj as Sortable).name
            
            println ( "obj name = \(name)")
        }

//Commented oct 27
        var sortedArray = sorted(unsortedArray) { ($0 as Sortable).name > ($1 as Sortable).name }
        
        println("\n\nSort complete...")
        
        for obj in sortedArray {
            
            var name = (obj as Sortable).name
            
            println ( "obj name = \(name)")
            
        }
    
    
        println("-------- END: Start Object sort ----------------")
    
    }
    
    
    //-------- End Object sort ----------------
    
    
    //-------- 3.3 Async network calls ------------
    
    @IBOutlet var searchTextField : UITextField?
    
    
    @IBAction func startSearch() {
        
        
        asyncNetworkCall()
        
    }
    
    func asyncNetworkCall() {
        
        
        //1. Get search term
        var searchTerm:String = searchTextField!.text
        

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
                
                self.errorLabel!.text = "Search term \(searchTerm) Result \(error.localizedDescription)"
                
            }//if
                
            else {
                
                 self.errorLabel!.text = ""
                
                var error: NSError?
                
                //5. Convert JSON to Dictionary
                let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
                
                
                // Now send the JSON result to our delegate object
                
                if (error? != nil) {
                    println("HTTP Error: \(error?.localizedDescription)")
                }//if
                else {
                    
                    println("\n\n-------- Response from iTunes --------\n\n")
                    println(jsonResult)
                }//else
                
            }//else
            
        }//closure ends here
        
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


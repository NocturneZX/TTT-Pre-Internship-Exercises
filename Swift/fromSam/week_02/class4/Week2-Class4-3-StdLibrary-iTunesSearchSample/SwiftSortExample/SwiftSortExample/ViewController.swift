//
//  ViewController.swift
//  SwiftSortExample
//
//  Created by Aditya Narayan on 6/10/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

import UIKit

import Foundation

class ViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource {
    
    
//    var items: Array<Dictionary<String,String>>()
    
    //items is an array of dictionary objects with string keys and string vals
    //var items = Dictionary<String, String>[]()
    var items:NSArray?
    
    var artistArray = Array<String>()
    
    @IBOutlet var albumDisplay : UITableView!

    
    var jsonResult:NSDictionary!
    
    //------- UIView callbacks ---------------
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Register the UITableViewCell class for reuse
        
        self.albumDisplay.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }

    
    
    
    //------- END: UIView callbacks ----------
    
    
    
    //-------- Async network calls --------
    
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
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {//closure starts here  ***!!! line 78 skips right down to 116, the closure section isn't called immediately, but as SOME point!  When it gets a response, then it runs the closure - note: there's a response obj, and an error obj.
            // if it doesn't work it errors, if it works there's a response OBJ
   
            
            (response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
            
            if (error != nil) {
                println("ERROR: \(error.localizedDescription)")
            }//if
            else {
                var jsonError: NSError?
                
                //5. Convert JSON to Dictionary  !! this is the important snippet that converts all the json result into a dictionary
              
                self.jsonResult
               
                = NSJSONSerialization.JSONObjectWithData(data,
                                                options: NSJSONReadingOptions.MutableContainers,
                                                error: &jsonError) as NSDictionary
                
                
                // Now send the JSON result to our delegate object
                
                if (jsonError? != nil) {
                    println("JSON Error: \(jsonError?.localizedDescription)")
                }//if
                else {
                    
                    println("\n\n-------- Response from iTunes --------\n\n")
                    println(self.jsonResult)
                    
                    //now call downloadComplete so we can show some results
                    
                    self.downloadComplete()
                    
                }//else
            }//else
        }//closure ends here
        
        println("Request sent to iTunes ....")
        
    }
    
    
    //-------- End Async network calls --------

    
    // parse the json into dictionary and parse data
    func downloadComplete() {
        
        // we know that the results key in the json is a collection of dictionaries
        var results:NSDictionary = self.jsonResult as NSDictionary  // better to acll it resultsDict so not confusiong
        
    
        var resultArray = results["results"] as NSArray // resultsDict["results"]

        
        var resultCount = results["resultCount"] as Int
        
        self.items = resultArray
        
        
        for var rowNum = 0; rowNum < resultCount; rowNum++ {

            var albumToDisplay:NSDictionary = self.items![rowNum] as NSDictionary
            
            var artistName =  albumToDisplay["collectionCensoredName"] as String

            artistArray.append(artistName)
            
            
        }
        
        
 //       self.items = results as Dictionary<String, String>[]
        
        println(self.items)
        
        
        self.albumDisplay.reloadData()
    }
    
    
    //-------- UITableView delegates ------------
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numRows = 0

        if (self.items != nil) {
        
            numRows = self.items!.count
            
        }
        
        return numRows
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell = self.albumDisplay.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        var rowNumber = indexPath.row
        
        //artistArray was created right after download
        var artistName = artistArray[rowNumber]
        
//        
//        var albumToDisplay:NSDictionary = self.items![rowNumber] as NSDictionary
//        
//         var artistName =  albumToDisplay["collectionCensoredName"] as String
        
        cell.textLabel!.text = artistName
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        println("You selected cell #\(indexPath.row)!")
        
    }

    //-------- END: UITableView delegates --------------------
    
    
    //-------- START: Sorting --------------------------------
    
    
    var counter = 0
    
    @IBAction func sortAlbum(sender : AnyObject) {
        
        var sortOrder:String?
        
        counter++;
        
        
        if counter % 2 == 0 {
            
            sortOrder = "ASC"
            
        } else {
            
            sortOrder = "DESC"
            
        }
        
         self.complexSort(sortOrder!)
        
    }
   
    func complexSort(var sortOrder:String) {
        
        println("-------- START: Start Object sort ----------------")
        
        var unsortedArray = self.artistArray
        
        if sortOrder == "ASC" {
            
            self.artistArray =  sorted(unsortedArray){$0 < $1}
            
        } else {
            
            self.artistArray =  sorted(unsortedArray){$1 < $0}
        }
        
        println("\n\nSort complete...")
        
        self.albumDisplay.reloadData()
        
        println("-------- END: Start Object sort ----------------")
        
    }
    
    
    //-------- END: Sorting ----------------------------------
    
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}


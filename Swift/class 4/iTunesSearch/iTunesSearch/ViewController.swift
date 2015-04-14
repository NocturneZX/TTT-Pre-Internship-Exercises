//
//  ViewController.swift
//  iTunesSearch
//
//  Created by Oren Goldberg on 7/23/14.
//  Copyright (c) 2014 Red Cloud Creations. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func asyncNetworkCall(sender: AnyObject) {
        //1. Get search term
        var searchTerm:String = searchTextField.text
        
        
        //2. Create URL with HTTP Request
        let urlPath = "https://itunes.apple.com/search?term=\(searchTerm)&media=music&entity=album"
        
        println("iTunes GET REQUEST \n\n \(urlPath)\n\n")
        
        //3. Create connection object
        let url: NSURL! = NSURL(string: urlPath)
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        //4. Make async call and declare 'closure on the fly' to accept the response whenever it is ready
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            {//closure starts here
            
            (response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
            
                if (error != nil) {
                    println("ERROR: \(error.localizedDescription)")
                }//if
                    
                else {
                    
                    var error: NSError?
                    
                    var alert = UIAlertController(title: "Connection Successful", message: "Data Received for \(searchTerm)", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    //5. Convert JSON to Dictionary
                    let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
                    
                    
                    // Now send the JSON result to our delegate object
                    
                    if error != nil{
                        println("HTTP Error: \(error?.localizedDescription)")
                    }//if
                    else {
                        
                        println("\n\n-------- Response from iTunes --------\n\n")
                        println(jsonResult)
                    }//else
                    
                }//else
            
        }//closure ends here
        
        println("last line")

    }
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


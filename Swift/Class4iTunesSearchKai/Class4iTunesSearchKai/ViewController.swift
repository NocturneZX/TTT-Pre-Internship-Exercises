//
//  ViewController.swift
//  Class4iTunesSearchKai
//
//  Created by Julio Reyes on 4/7/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    
    var items: [String] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: IBActions
    @IBAction func searchButton(sender: AnyObject) {
        println("Button Pressed!");
        
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
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { action in
                        switch action.style{
                        case .Default:
                            println("default")
                        case .Cancel:
                            println("Cancel")
                        case .Destructive:
                            println("ASSPLODE!")
                        }
                    }))
                    
                    self.presentViewController(alert, animated: true, completion: nil)

                    //5. Convert JSON to Dictionary
                    let jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
                    
                    var albumName = jsonResult["results.collectionName"] as? String
                     println("\(albumName)")

//                    self.items.append(albumName!)
//                   
//                    var albumKey = "collectionName"

                    // Now send the JSON result to our delegate object
//                    jsonResult.enumerateKeysAndObjectsUsingBlock{(key, obj, stop) -> Void in
//                        var albumName = obj.valueForKey("collectionName") as? String
//                        println("\(albumName)")
//                        
//                    }
                    
                    if error != nil{
                        println("HTTP Error: \(error?.localizedDescription)")
                    }//if
                    else {
                        
                        println("\n\n-------- Response from iTunes --------\n\n")
                        println(jsonResult)
                        
                        
                        
    
                        
                    }//else
                    
                }//else
                
        }//closure ends here

    }
    @IBAction func sortTable(sender: AnyObject) {
        
    }
    @IBOutlet weak var iTunesTableView: UITableView!
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}


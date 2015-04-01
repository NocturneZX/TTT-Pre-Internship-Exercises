//
//  SecondViewController.swift
//  SwiftTabAppSample
//
//  Created by Oren Goldberg on 12/10/14.
//  Copyright (c) 2014 Turn To Tech. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate
 {

    @IBOutlet var txtNotify: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveNotification:", name: "Test1", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveNotification:", name: "Test2", object: nil)
    }

    
    @IBAction func onePressed(sender: AnyObject) {
        var extraInfo:Dictionary = ["button_name":"One"]
        NSNotificationCenter.defaultCenter().postNotificationName("Test1", object: nil, userInfo: extraInfo)
        
    }
    
    @IBAction func twoPressed(sender: AnyObject) {
        var extraInfo:Dictionary = ["button_name":"Two"]
        NSNotificationCenter.defaultCenter().postNotificationName("Test2", object: nil, userInfo: extraInfo)

    }
    
    func receiveNotification(notification:NSNotification) {
        println("Second View Notification received: \(notification.name)")
        var extra_info:NSDictionary
        extra_info = notification.userInfo!
        txtNotify.text = extra_info["button_name"] as? String
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
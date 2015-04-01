//
//  FirstViewController.swift
//  SwiftTabAppSample
//
//  Created by Oren Goldberg on 12/10/14.
//  Copyright (c) 2014 Turn To Tech. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet var txtCounter1: UITextField!
    @IBOutlet var txtCounter2: UITextField!
    var counter1:Int = 0
    var counter2:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveNotification:", name: "Test1", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "receiveNotification:", name: "Test2", object: nil)
        
    }
    
    func receiveNotification(notification:NSNotification) {
        println("First View Notification Received: \(notification.name)")
        var extraInfo:Dictionary = notification.userInfo!
        
        if (notification.name == "Test1") {
            counter1++
            var button_name:AnyObject = extraInfo["button_name"]!
            txtCounter1.text = "\(button_name) \(counter1)"
        } else {
            counter2++
            var button_name:AnyObject = extraInfo["button_name"]!
            txtCounter2.text = "\(button_name) \(counter2)"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
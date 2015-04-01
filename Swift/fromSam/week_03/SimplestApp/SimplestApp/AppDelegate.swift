//
//  AppDelegate.swift
//  SimplestApp
//
//  Created by Aditya Narayan on 7/30/14.
//  Copyright (c) 2014 Aditya Narayan. All rights reserved.
//

import UIKit

//1. Comment this and see what happens..
@UIApplicationMain  // for the system, it looks like an app and it can run


class AppDelegate: UIResponder, UIApplicationDelegate {// extend UIResponder, implements UIApp protocol
                            
    var window: UIWindow?

// need to run at least one of the functions of UIApplicationDelegate, always use 'application' else you just have a black screen
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        // Override point for customization after application launch.
        self.window!.backgroundColor = UIColor.greenColor()
        
        //2. Add a subview  // this is the blue subview
         addASubview()
        
        self.window!.makeKeyAndVisible() // must be called on the window object for it to be viewable.. else you can't see it.. this is the root view.
        
        return true
    }
    
    func addASubview() {
       
          var view = MyView(frame: CGRect(x: 10, y: 10, width: 500, height: 500))
        
          view.backgroundColor = UIColor.blueColor()
        
          var button = UIButton(frame: CGRect(x: 5, y: 50, width: 250, height: 22))
          button.backgroundColor = UIColor.grayColor()
        
          button.setTitle("Class 6", forState: UIControlState.Normal)
          button.setTitle("Class 6 - hi", forState: UIControlState.Highlighted)
          button.enabled = true
        
          //3. Add a target - trigger a function when the button is pressed, the colon after 'pressed' means it takes an argument.. need this or it will crash.  if the function that is supposed to be called does not exist, the error: unrecognized selector, will show up in the console.
          button.addTarget(self, action: "pressed:", forControlEvents: .TouchUpInside)
        
          view.addSubview(button)
        
          var textField1 = UITextField(frame: CGRect(x: 5, y: 150, width: 250, height: 22))
          textField1.backgroundColor = UIColor.whiteColor()
        
        
          window!.addSubview(view)  // adding the view that was created to the window view
          window!.addSubview(textField1)
        
    }

    func pressed(sender: UIButton!) {
        
        var alertView = UIAlertView();
        alertView.addButtonWithTitle("OK");
        alertView.title = "Button Pressed";
        alertView.show();
        
    }
    
    //4. Various callbacks for app states
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        
        println("App will be minimized ...")
        
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        println("App will enter background ...")
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        
        println("App will entered foreground ...")
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        println("App is now active ...")
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // cmd+shift+h x2 to bring up exit program screens
        println("app is terminating")
    }


}

//---------- 5. A custom View class ---------------

class MyView:UIView {   //extends UIView
    
     //6. Test if there was a moving touch in this view
    
     override func touchesMoved(touches: NSSet , withEvent event: UIEvent) {
        
        println("touches moved ...")
        
        //println(event.description)
        
    }

    //7. Test if tap was inside this view   pointInside is a built in function
// in the MyView subclass of UIView, we have access to the pointInside function, but we want to customize the functionality so we 'override' the function, when inside our override function, we set var pointInside as a function that calls the original pointInside function using 'super'.. then below it, write in the additional custom functionality
    override func pointInside(point: CGPoint, withEvent event: UIEvent!) -> Bool  {
        
        
        var pointInside = super.pointInside(point, withEvent: event)
        //  definition:   func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool // default returns YES if point is in bounds

        if pointInside {
 
            println("tapped point is inside blue region ...")
            
        } else {
            
            println("tapped point is outside blue region ...")
        }
        
        return pointInside
        
    }
    
}


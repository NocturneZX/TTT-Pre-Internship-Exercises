//
//  ItemViewController.swift
//  ShoppingList
//
//  Created by Oren Goldberg on 8/18/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

import UIKit
import CoreData

class ItemViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var infoTextField: UITextField!
    
    var existingItem:NSManagedObject!
    var existingContext:NSManagedObjectContext!
    
    var name: String = ""
    var quantity: String = ""
    var info: String = ""
    var colorCount: Int = 0
    var colorCountBuffer: Int = 0
    var colorArray: [UIColor] = []
    var color: UIColor = UIColor.whiteColor()
    var standardUserDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        if existingItem != nil {
            nameTextField.text = name
            quantityTextField.text = quantity
            infoTextField.text = info
        }
        
        if (NSUserDefaults.standardUserDefaults().objectForKey(self.name) != nil) {
            var colorData:NSData = NSUserDefaults.standardUserDefaults().objectForKey(self.name) as NSData
            var color:UIColor = NSKeyedUnarchiver.unarchiveObjectWithData(colorData) as UIColor
            self.color = color
            self.view.backgroundColor = color
            

        }
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        self.view.addGestureRecognizer(swipeRight)
        
        var swipeLeft = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeLeft)
        
        var swipeDown = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeDown.direction = UISwipeGestureRecognizerDirection.Down
        self.view.addGestureRecognizer(swipeDown)
        
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "respondToSwipeGesture:")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        self.view.addGestureRecognizer(swipeUp)
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Up:
                println("Swiped up")
                if (self.colorArray.count == 0){
                    self.colorArray.append(self.view.backgroundColor!)
                }

                var randomRed:CGFloat = CGFloat(drand48())
                
                var randomGreen:CGFloat = CGFloat(drand48())
                
                var randomBlue:CGFloat = CGFloat(drand48())
                
                self.color = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1)
                
                self.view.backgroundColor = self.color
                
                colorCountBuffer = self.colorArray.count
                
                self.colorArray.append(self.view.backgroundColor!)

                
            case UISwipeGestureRecognizerDirection.Right:
                println("Swiped right")
                colorCount = self.colorArray.count

                if (self.colorArray.count != 0 && colorCountBuffer < colorCount  - 1){
                    colorCountBuffer++
                    var nextColor:UIColor = self.colorArray[colorCountBuffer]
                    self.view.backgroundColor = nextColor
                }
                
            case UISwipeGestureRecognizerDirection.Left:
                println("Swiped left")
                colorCount = self.colorArray.count
                if (self.colorArray.count != 0 && colorCountBuffer != 0){
                    colorCountBuffer--
                    var prevColor:UIColor = self.colorArray[colorCountBuffer]
                    self.view.backgroundColor = prevColor
                }
            case UISwipeGestureRecognizerDirection.Down:
                println("Swiped down")
                var colorData:NSData = NSKeyedArchiver.archivedDataWithRootObject(self.color)
                standardUserDefaults.setObject(colorData, forKey:self.name)
                println(standardUserDefaults.synchronize())
                
            default:
                break
            }
        }
    }
    
    
    
    @IBAction func saveTapped(sender: AnyObject) {
        //save color
        var colorData:NSData = NSKeyedArchiver.archivedDataWithRootObject(self.color)
        
        
        //reference to our app delegate
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        
        //reference model object context
        
        let contxt: NSManagedObjectContext = appDel.managedObjectContext!
        let en = NSEntityDescription.entityForName("List", inManagedObjectContext: contxt)
        
        //check if item exists
        if existingItem != nil {
            existingItem.setValue(nameTextField.text as String, forKey: "name")
            existingItem.setValue(quantityTextField.text as String, forKey: "quantity")
            existingItem.setValue(infoTextField.text as String, forKey: "info")
            
            standardUserDefaults.setObject(colorData, forKey:nameTextField.text)
        } else {
            //create instance of data model and initialize
            
            var newItem = Model(entity: en!, insertIntoManagedObjectContext: contxt)
            
            //map input to  item properties
            
            newItem.name = self.nameTextField.text
            newItem.quantity = self.quantityTextField.text
            newItem.info = self.infoTextField.text
            
            //save context
            
            
            
            standardUserDefaults.setObject(colorData, forKey:newItem.name)
            
            
            
        }
        contxt.save(nil)
        println(standardUserDefaults.synchronize())
        //navigate back to root vc
        
        self.navigationController!.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.navigationController!.popToRootViewControllerAnimated(true)
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

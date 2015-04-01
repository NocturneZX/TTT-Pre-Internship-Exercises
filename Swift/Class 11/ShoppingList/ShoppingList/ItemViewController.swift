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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if existingItem != nil {
            nameTextField.text = name
            quantityTextField.text = quantity
            infoTextField.text = info
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        

    }
    
    @IBAction func saveTapped(sender: AnyObject) {
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
            NSLog("%@",existingItem.description)
        } else {
            //create instance of data model and initialize
            
            var newItem = Model(entity: en!, insertIntoManagedObjectContext: contxt)
            
            //map input to  item properties
            
            newItem.name = self.nameTextField.text
            newItem.quantity = self.quantityTextField.text
            newItem.info = self.infoTextField.text

        }
        
        // Save context
        contxt.save(nil);
        
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

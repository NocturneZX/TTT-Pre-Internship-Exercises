//
//  ListTableViewController.swift
//  ShoppingList
//
//  Created by Oren Goldberg on 8/18/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController {
    
    var myList :Array<AnyObject> = []
    var standardUserDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDel.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName: "List")
        
        let searchText = "Apple"
        let namePredicate = NSPredicate(format: "name contains [c] %@", searchText)
        let quanPredicate = NSPredicate(format: "quantity contains [c] %@", "5");

        var compound = NSCompoundPredicate.andPredicateWithSubpredicates([namePredicate!, quanPredicate!])
        fetchRequest.predicate = compound;
        
        myList = context.executeFetchRequest(fetchRequest, error: nil)!
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return myList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let CellID: NSString = "Cell"
        
        var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(CellID) as UITableViewCell
        // Configure the cell...
        
        var data: NSManagedObject = myList[indexPath.row] as NSManagedObject
        var name = data.valueForKeyPath("name") as String
        cell.textLabel!.text = name
        
        if (standardUserDefaults.objectForKey(name) != nil) {
            var colorData:NSData = NSUserDefaults.standardUserDefaults().objectForKey(name) as NSData
            var color:UIColor = NSKeyedUnarchiver.unarchiveObjectWithData(colorData) as UIColor
            cell.backgroundColor = color
        }
        
        var qnt = data.valueForKeyPath("quantity") as String
        var inf = data.valueForKeyPath("info") as String
        
        if (qnt.toInt() != 1) {
            cell.detailTextLabel!.text = "\(qnt) items  \(inf)"
        } else {
            cell.detailTextLabel!.text = "\(qnt) item  \(inf)"
        }

        
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }



    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let context: NSManagedObjectContext = appDelegate.managedObjectContext!
        
        if editingStyle == .Delete {
                // Delete the row from the data source
                context.deleteObject(myList[indexPath.row] as NSManagedObject)
                myList.removeAtIndex(indexPath.row)
                
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

            
            var error: NSError? = nil
            if !context.save(&error) {
                abort()
            }
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
//        let cell = sender as UITableViewCell
        if segue.identifier? == "update" {
            var indexPath = self.tableView.indexPathForCell(sender! as UITableViewCell)
            var selectedItem: NSManagedObject = myList[indexPath!.row] as NSManagedObject
            
            let itemViewController: ItemViewController = segue.destinationViewController as ItemViewController
            itemViewController.name = selectedItem.valueForKey("name") as String
            itemViewController.quantity = selectedItem.valueForKey("quantity") as String
            itemViewController.info = selectedItem.valueForKey("info") as String
            itemViewController.existingItem = selectedItem
            
        }
        
    }

}

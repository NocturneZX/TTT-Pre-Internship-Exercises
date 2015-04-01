 //
//  ProductViewController.swift
//  navController
//
//  Created by FT_MacBookPro on 2/19/15.
//  Copyright (c) 2015 FTslo. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView! // why does this have an exclamation mark / unwrapping?
    
    var company:Company?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.title = self.company!.name
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.company!.products.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        var product = self.company!.products[indexPath.row]
        cell.textLabel!.text = product.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        self.company?.products.removeAtIndex(indexPath.row)
        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Middle)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//  auto layout can be turned off in the File Inspector panel

//  is initial view controller option must be selected for the Navigation controller on the Storyboard in the Attributes Inspector, otherwise you get the following error:
//  Failed to instantiate the default view controller for UIMainStoryboardFile 'Main' - perhaps the designated entry point is not set?

//  without setting the tableView as an outlet in the CompanyViewController, this error occurs
//  fatal error: unexpectedly found nil while unwrapping an Optional value
 
 // storyboard ID setting for product VC in the Identity attributes panel
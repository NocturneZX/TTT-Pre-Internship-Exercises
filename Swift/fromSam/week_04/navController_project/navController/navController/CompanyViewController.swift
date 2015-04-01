//
//  ViewController.swift
//  navController
//
//  Created by FT_MacBookPro on 2/19/15.
//  Copyright (c) 2015 FTslo. All rights reserved.
//

import UIKit
/* CompanyViewController is a subclass of UIViewController, but also adding capabilities of TableView which requires TBVDelegate and TBVDataSource
*/
class CompanyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet
    var tableView: UITableView! // why does this have an exclamation mark / unwrapping?x
    var dataInit = DataInit()   // this is instantiating the DAO Class that we set up previously
    var companies:[Company]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.companies = self.dataInit.getCompanies()
    }
    
    override func viewWillAppear(animated:Bool) {
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//  see most updated documentation: http--developer.apple.com/library/ios/documentation/UIKit/Reference/UITableViewDataSource_Protocol/index.html#//apple_ref/occ/intfm/UITableViewDataSource/tableView:numberOfRowsInSection:
//  the video has ! in the callbacks, that's causing errors b/c Swift has been updated

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // explanation at minute 25

        return self.companies!.count
    }

    func numberOfSectionsInTableView(tableView:UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // explanation at minute 28
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        var company = self.companies![indexPath.row]
        // syntax is different from the video, textLabel and imageView are optionals
        cell.textLabel!.text = "\(company.name!)"
        var image = UIImage(named:"\(company.name!).jpg")
        cell.imageView!.image = image
    
            
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        let productViewController =
        
        self.storyboard?.instantiateViewControllerWithIdentifier("ProductViewController") as ProductViewController
        productViewController.company = self.companies![indexPath.row]
        self.navigationController?.pushViewController(productViewController, animated: true)
    }
}




































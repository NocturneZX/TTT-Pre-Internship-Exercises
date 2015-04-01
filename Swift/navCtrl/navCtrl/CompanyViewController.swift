//
//  CompanyViewController.swift
//  navCtrl
//
//  Created by Julio Reyes on 2/19/15.
//  Copyright (c) 2015 JulioReyesCorps. All rights reserved.
//

import UIKit
import Foundation

class CompanyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet
    var tableView: UITableView!
    var dataInit = DataInit()
    var companies:Array<Company>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.companies = self.dataInit.getCompanies();
    }
    
    override func viewDidAppear(animated: Bool) {
//        var stockArray:Array<String> = [];
//        for (var i = 0; i < self.companies?.count; i++){
//            var company = self.companies[i]
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.companies!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell;
        var company = self.companies![indexPath.row];
        var na = "N/A";
        var emptyString = "";
        cell.textLabel.text = "\(company.name!)";
        var image = UIImage(named:"\(company.name!).jpeg");
        cell.imageView.image = image;
        
        return cell;
        
 
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let productViewController = self.storyboard?.instantiateViewControllerWithIdentifier("ProductViewController") as ProductViewController;
        productViewController.company = self.companies![indexPath.row];
        self.navigationController!.pushViewController(productViewController, animated: true);
        
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }

}


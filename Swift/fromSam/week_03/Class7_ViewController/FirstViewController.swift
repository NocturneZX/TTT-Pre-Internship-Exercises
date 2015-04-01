//
//  FirstViewController.swift
//  FirstApp
//
//  Created by Aditya Narayan on 6/6/14.
//  Copyright (c) 2014 QCD Systems. All rights reserved.
//

import UIKit
import Foundation

class FirstViewController: UIViewController {
   
    /*

    
    A. If you use Interface Builder to create your views and initialize the view controller, you must not override this method.
    
    B. You can override this method in order to create your views manually. If you choose to do so, assign the root view of your view hierarchy to the view property.
    
    C. The views you create should be unique instances and should not be shared with any other view controller object. Your custom implementation of this method should not call super.



    */

    
    @IBOutlet weak var myTextArea: UITextView!
    
    @IBOutlet weak var myLabel: UILabel!
    
    
    override func loadView()
    {
    
    //super.loadView(); // if you override loadView(), you aren't supposed to call super.loadView();
    
    //NSArray *nib =[[NSBundle mainBundle]loadNibNamed:@"test" owner:self options:nil];
    //self.view = [nib objectAtIndex:0];
      

    //var nibs = NSBundle.mainBundle().loadNibNamed("NewView", owner: self, options: nil)
        
     var nibs = NSBundle.mainBundle().loadNibNamed("FirstViewController", owner: self, options: nil)
        
     self.view =  nibs[0] as UIView
        
        
    }

    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        println("----- viewWillAppear")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        println("----- viewDidAppear")
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        println("------ viewDidLoad")
        
        //  dump(self)
        
        
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        
        super.viewDidDisappear(animated)
        
        println("----- viewDidDisappear")

        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTapped() {
        
        println("Button tapped ...")
        
        //---- Login ---
        
        var loginHandler = Login()
        
        loginHandler.performAction()
        
    }
    
    
    @IBAction func myButtonAction(sender: UIButton) {
        var passedText = myTextArea.text
        myLabel.text = passedText
    }
    
    

}

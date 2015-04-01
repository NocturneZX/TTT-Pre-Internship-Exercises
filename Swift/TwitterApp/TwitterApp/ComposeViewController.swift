//
//  ComposeViewController.swift
//  SwifferApp
//
//  Created by TurnToTech on 29/06/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var tweetTextView: UITextView! = UITextView()
    @IBOutlet var charRemainingLabel: UILabel! = UILabel()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tweetTextView.layer.borderColor = UIColor.blackColor().CGColor
        tweetTextView.layer.borderWidth = 0.5
        tweetTextView.layer.cornerRadius = 5
        tweetTextView.delegate = self
        
        tweetTextView.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendTweet(sender: AnyObject) {
        
        var tweet:PFObject = PFObject(className: "Tweets")
        tweet["content"] = tweetTextView.text
        tweet["tweeter"] = PFUser.currentUser()
        
        tweet.saveInBackground()
        
        self.navigationController!.popToRootViewControllerAnimated(true)
        
    }

    
    func textView(textView: UITextView!,
        shouldChangeTextInRange range: NSRange,
        replacementText text: String!) -> Bool{
    
            var newLength:Int = (textView.text as NSString).length + (text as NSString).length - range.length
            var remainingChar:Int = 140 - newLength
            
            charRemainingLabel.text = "\(remainingChar)"
            
            return (newLength > 140) ? false : true
    }
    
    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

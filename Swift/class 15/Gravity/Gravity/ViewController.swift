//
//  ViewController.swift
//  Gravity
//
//  Created by Oren Goldberg on 9/2/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var fallingLabel: UILabel!
    @IBOutlet weak var square2: UIImageView!
    @IBOutlet weak var square3: UIImageView!
    @IBOutlet weak var square4: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var boolSwitch: UISwitch!
    @IBOutlet var stableLabel: UILabel!
    @IBOutlet weak var mapDisplay: MKMapView!
    @IBOutlet weak var stepperControl: UIStepper!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var animator:UIDynamicAnimator?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        animator = UIDynamicAnimator(referenceView: self.view)
        
        var items = [self.fallingLabel, self.square2,self.square3,self.square4,self.slider,self.boolSwitch, self.mapDisplay, self.stepperControl]
        
        var items2 = [self.fallingLabel, self.square2,self.square3,self.square4, self.slider, self.boolSwitch, self.stepperControl, self.stableLabel]
        
        
        var gravityBehavior : UIGravityBehavior = UIGravityBehavior(items: items)
        gravityBehavior.gravityDirection = CGVectorMake(0,0)
        
        animator?.addBehavior(gravityBehavior)
        
        var collisionBehavior : UICollisionBehavior = UICollisionBehavior(items: items2)
        
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        animator?.addBehavior(collisionBehavior)
    }
    
    @IBAction func upDownSwitch(sender: AnyObject) {
       
        var gravity:UIGravityBehavior = animator?.behaviors[0] as UIGravityBehavior
        
        switch segmentedControl.selectedSegmentIndex
            {
        case 0:
             gravity.gravityDirection = CGVectorMake(0,-1)
        case 1:
            gravity.gravityDirection = CGVectorMake(0, 1)
        default:
            break
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


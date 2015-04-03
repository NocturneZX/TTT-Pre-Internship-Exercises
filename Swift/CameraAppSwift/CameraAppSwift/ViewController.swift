//
//  ViewController.swift
//  CameraAppSwift
//
//  Created by Julio Reyes on 3/12/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPopoverControllerDelegate {
    
    var pop:UIPopoverController?
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func TakePhoto(sender: AnyObject){
        
        var imagePicker = UIImagePickerController()
        imagePicker.delegate = self;
        
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
        imagePicker.mediaTypes = NSArray(object: kUTTypeImage);
        imagePicker.allowsEditing = false;
        
        if(UIDevice.currentDevice().userInterfaceIdiom == .Phone)
        {
            self.presentViewController(imagePicker, animated: true, completion: nil)
            
        }else{
            
            pop = UIPopoverController(contentViewController: imagePicker);
            
            pop!.contentViewController = imagePicker;
            pop!.delegate = self
            
            pop!.contentViewController = imagePicker
            pop!.delegate = self;
            
            pop!.presentPopoverFromBarButtonItem(sender as UIBarButtonItem, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true);
        }
        
    }
    
    //MARK - Image Pricker Delegate
    // The picker does not dismiss itself; the client dismisses it in these callbacks.
    // The delegate will receive one or the other, but not both, depending whether the user
    // confirms or cancels.
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage
        image: UIImage!, editingInfo: NSDictionary!){
            println("i've got an image");
            if(UIDevice.currentDevice().userInterfaceIdiom == .Phone)
            {
                self.imageView.image = image;
                self.dismissViewControllerAnimated(true, completion: nil)
            }else{
                self.imageView.image = image;
                pop?.dismissPopoverAnimated(true);
            }
            //
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]){
            if(UIDevice.currentDevice().userInterfaceIdiom == .Phone)
            {
                self.imageView.image = (info[UIImagePickerControllerOriginalImage] as UIImage);
                self.dismissViewControllerAnimated(true, completion: nil)
            }else{
                self.imageView.image = (info[UIImagePickerControllerOriginalImage] as UIImage);
                pop?.dismissPopoverAnimated(true);
            }
            
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController){
        if(UIDevice.currentDevice().userInterfaceIdiom == .Phone)
        {
            self.dismissViewControllerAnimated(true, completion: nil)
        }else{
            pop?.dismissPopoverAnimated(true);
        }
    }
    
}


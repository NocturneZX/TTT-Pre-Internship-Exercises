//
//  ViewController.swift
//  FlickrInSwift
//
//  Created by Julio Reyes on 4/14/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var flickrCollectionView: UICollectionView!
        
    private let reuseIdentifier = "FlickrCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

    var photosets: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        flickrCollectionView!.registerClass(FlickrCVCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let flickrDownloader: FlickrDataDownloader =  FlickrDataDownloader()

        flickrDownloader.getArrayOfPhotoObjectsforTheSearchTerm("Gundam", completion: { (searchString:String!, flickrPhotos:NSMutableArray!, error:NSError!) -> () in
            
            self.photosets = NSMutableArray(array: flickrPhotos)
          
            dispatch_async(dispatch_get_main_queue(), {

                self.flickrCollectionView.reloadData()

            })
            //println(self.photosets)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UICollectionView Methods
    //2
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosets.count > 0 ?  photosets.count: 0;
    }
    
    //3
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:FlickrCVCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FlickrCVCell
        cell.backgroundColor = UIColor.redColor()
        
        let currentPhoto: FlickrPhoto = self.photosets[indexPath.row] as! FlickrPhoto
    
        // If the image does not exist, we need to download it
        var imgURL: NSURL = currentPhoto.filckrphotoImageURL!
        var image: UIImage?
        //println("\(imgURL)");
        
        // Download an NSData representation of the image at the URL
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
            
            (response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
            if error == nil {
                image = UIImage(data: data)
                
                // Store the image in to our cache
                dispatch_async(dispatch_get_main_queue(), {
                    if let cellToUpdate: FlickrCVCell = collectionView.cellForItemAtIndexPath(indexPath) as? FlickrCVCell{
                        cellToUpdate.FlickrCVImageView?.image = image
                        self.flickrCollectionView.reloadData()
                    }
                })
            }
            else {
                println("Error: \(error.localizedDescription)")
            }
        })
        
        
        // Configure the cell
        return cell
    }

    
}


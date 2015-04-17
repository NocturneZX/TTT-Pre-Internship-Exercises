//
//  FlickrDataDownloader.swift
//  FlickrInSwift
//
//  Created by Julio Reyes on 4/14/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

import UIKit

class FlickrDataDownloader: NSObject{
    
    let PHOTO_COUNT:Int = 20
    let FLICKR_API_KEY:String = "cb9ddc90f13df3d47819c30111c851be"
    let FLICKR_SECRET_KEY:String =  "d198467a13b07d76"
    let searchTerm = "Gundam"
    let currentpage:Int = 0
    
    func getArrayOfPhotoObjectsforTheSearchTerm(searchStr:String,
        completion:(searchString:String!, flickrPhotos:NSMutableArray!, error:NSError!)->())
    {
        currentpage + 1
        
        let concatURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(FLICKR_API_KEY)&text=\(self.searchTerm)&sort=interestingness-desc&page=\(currentpage)&per_page=\(PHOTO_COUNT)&format=json&nojsoncallback=1"
        
        var error:NSError?
        var data:NSData?
        var response: NSURLResponse?
        
        let searchURL: NSURL = NSURL(string: concatURL)!
        
        if error != nil{
            completion(searchString: searchStr, flickrPhotos: nil, error: error)
        }else{
            
            let request: NSURLRequest = NSURLRequest(URL: searchURL)
            let operationQueue: NSOperationQueue = NSOperationQueue()
            operationQueue.maxConcurrentOperationCount = 1
            
            let flickrTask: NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data: NSData!,response: NSURLResponse!,error: NSError!) -> Void in  //closure starts here

                if(error != nil){
                    completion(searchString: searchStr, flickrPhotos: nil, error: error)
                }else{
                    let results = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil) as! NSDictionary
                    let resultArray:NSArray = results.valueForKeyPath("photos.photo") as! NSArray
                    
                    let flickrPhotos:NSMutableArray = NSMutableArray()
                    
                    for photoObject in resultArray{
                        let photoDict:NSDictionary = photoObject as! NSDictionary
                        //println(photoDict)
                        var flickrPhoto:FlickrPhoto = FlickrPhoto(photoID: nil,photoTitle: nil,photoURL: nil,photoThumbURL: nil,photoAuthor: nil)
                        
                        var farm = photoDict.objectForKey("farm") as! Int
                        var server = photoDict.objectForKey("server")as! String
                        var secret = photoDict.objectForKey("secret") as! String
                        var photoID = photoDict.objectForKey("id")as! String
                        
                        var owner = photoDict["owner"] as! String
                        var title = photoDict["title"] as! String
                        
                        var httpThumbString = "http://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_t.jpg" as String
                        var photoThumbURL = NSURL(string: httpThumbString)
                        
                        var httpImageString = "http://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_m.jpg" as String
                        var photoURL = NSURL(string: httpThumbString)
                        
                        //Setup the Flickr class
                        flickrPhoto.filckrphotoID = photoID;
                        flickrPhoto.filckrphotoTitle = title;
                        flickrPhoto.filckrphotoImageURL = photoURL;
                        flickrPhoto.filckrphotoThumbnailImageURL = photoThumbURL;
                        flickrPhoto.filckrphotoAuthor = owner;
                        
                        flickrPhotos.addObject(flickrPhoto)
                        
                    }
                    
                    completion(searchString: searchStr, flickrPhotos: flickrPhotos, error: nil) // Return the data to the main thread
                }
            });// Closure ends here
            
            flickrTask.resume()
        }
    }
}
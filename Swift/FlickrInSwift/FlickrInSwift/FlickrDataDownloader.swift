//
//  FlickrDataDownloader.swift
//  FlickrInSwift
//
//  Created by Julio Reyes on 4/14/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

import UIKit

class FlickrDataDownloader: NSObject {
    
    let PHOTO_COUNT:Int = 20
    let FLICKR_API_KEY:String = "cb9ddc90f13df3d47819c30111c851be"
    let FLICKR_SECRET_KEY:String =  "d198467a13b07d76"
    let searchTerm = "Gundam"
    
    func getArrayOfPhotoObjectsforTheSearchTerm(searchStr:String,
        completion:(searchString:String!, flickrPhotos:NSMutableArray!, error:NSError!)->())
    {
        
    }
}
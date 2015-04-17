//
//  FlickrPhoto.swift
//  FlickrInSwift
//
//  Created by Julio Reyes on 4/16/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

import UIKit

class FlickrPhoto: NSObject {
    var filckrphotoID: NSString!;
    var filckrphotoTitle: NSString?;
    var filckrphotoImageURL:NSURL!;
    var filckrphotoThumbnailImageURL: NSURL!;
    var filckrphotoAuthor:NSString!;
    
    init(photoID: NSString?, photoTitle: NSString?, photoURL: NSURL?,
        photoThumbURL: NSURL?, photoAuthor: NSString?) {

                self.filckrphotoID = photoID
                self.filckrphotoTitle = photoTitle
                self.filckrphotoImageURL = photoURL
                self.filckrphotoThumbnailImageURL = photoThumbURL
                self.filckrphotoAuthor = photoAuthor
    }
}

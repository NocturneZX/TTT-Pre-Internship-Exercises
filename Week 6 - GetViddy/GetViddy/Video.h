//
//  Video.h
//  GetViddy
//
//  Created by Julio Reyes on 4/28/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Video : NSObject
@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, strong) NSURL *uniqueURL;
@end

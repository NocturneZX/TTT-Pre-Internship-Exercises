//
//  DEMORect.m
//  CreatesUiProgramatically
//
//  Created by Julio Reyes Narayan on 3/23/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "DEMORect.h"

@implementation DEMORect

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGPoint center = CGPointMake(self.frame.size.width / 2.0, self.frame.size.height / 2.0);
    float rectangleWidth = 100.0;
    float rectangleHeight = 100.0;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //4
    CGContextAddRect(ctx, CGRectMake(center.x - (0.5 * rectangleWidth), center.y - (0.5 * rectangleHeight), rectangleWidth, rectangleHeight));
    CGContextSetLineWidth(ctx, 10);
    CGContextSetStrokeColorWithColor(ctx, [[UIColor grayColor] CGColor]);
    CGContextStrokePath(ctx);
    
    //5
    CGContextSetFillColorWithColor(ctx, [[UIColor greenColor] CGColor]);
    CGContextAddRect(ctx, CGRectMake(center.x - (0.5 * rectangleWidth), center.y - (0.5 * rectangleHeight), rectangleWidth, rectangleHeight));
    CGContextFillPath(ctx);
}


@end

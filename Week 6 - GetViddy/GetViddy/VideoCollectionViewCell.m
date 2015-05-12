//
//  VideoCollectionViewCell.m
//  GetViddy
//
//  Created by Julio Reyes on 4/28/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "VideoCollectionViewCell.h"

static CGSize extraMargins = {0, 0};

@implementation VideoCollectionViewCell
-(CGSize)intrinsicContentSize{
    CGSize thumbSize = [self.videoThumbImageview intrinsicContentSize];
    if (CGSizeEqualToSize(extraMargins, CGSizeZero)) {
        for (NSLayoutConstraint *constraint in self.constraints) {
            if (constraint.firstAttribute == NSLayoutAttributeBottom || constraint.firstAttribute == NSLayoutAttributeTop)
                // Set vertical spacer
                extraMargins.height += [constraint constant];
            else if (constraint.firstAttribute == NSLayoutAttributeLeading || constraint.firstAttribute == NSLayoutAttributeTrailing)
                extraMargins.width += [constraint constant];
        }
    }
    
    // add to intrinsic content size of label
    thumbSize.width += extraMargins.width;
    thumbSize.height += extraMargins.height;
    
    return thumbSize;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    // reset image property of imageView for reuse
    self.videoThumbImageview.image = nil;
    
    // update frame position of subviews
    self.videoThumbImageview.frame = self.contentView.bounds;
    
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    
    // Apply image masking in the cell
    self.layer.cornerRadius = 10;
    self.layer.borderWidth = 2;
    self.layer.borderColor = [UIColor colorWithRed:120.0/255.0 green:110.0/255.0 blue:100.0/255.0 alpha:0.9].CGColor;
    self.layer.masksToBounds = YES;
    
    self.layer.shadowOpacity = 2.0f;
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowOffset = CGSizeMake(10, 10);
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.layer.bounds cornerRadius:75].CGPath;
    self.layer.shadowColor = [UIColor clearColor].CGColor;
    self.layer.sublayerTransform = CATransform3DIdentity;
    
    self.layer.shouldRasterize = YES;
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    self.contentView.frame = bounds;
}
@end

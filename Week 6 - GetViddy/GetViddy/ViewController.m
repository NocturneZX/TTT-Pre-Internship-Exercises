//
//  ViewController.m
//  GetViddy
//
//  Created by Julio Reyes on 4/22/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "ViewController.h"
#import "Video.h"
#import "VideoCollectionViewCell.h"
#import "PlayViewController.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout>{
    
        VideoCollectionViewCell *currentCell;
    
}
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) IBOutlet UIView *assetView;

@property (nonatomic, strong) NSMutableArray *videoArray;
//@property (nonatomic, strong) NSMutableSet *uniqueURLs;// Hold video URLs

@end

@implementation ViewController
static NSString *cellIdentifier = @"videoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    [flowLayout setItemSize:CGSizeMake(200, 200)];
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
//    
//    [self.collectionView setCollectionViewLayout:flowLayout];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.myAssetLibrary = [[ALAssetsLibrary alloc]init];
    self.videoArray = [[NSMutableArray alloc]init];
    
    [self getMyVideos];

    
}
-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.myAssetLibrary = nil;
    self.videoArray = nil; 
}
-(void)getMyVideos{
    
    // This block will enumerate the results of the enumerateAssetsUsingBlock. The results will be all videos in phone and iTunes
    ALAssetsGroupEnumerationResultsBlock enumBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            NSLog(@"%@", result.description);
            if ([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) // Not really necessary because of filter. Just for learning purposes.
            {
                ALAssetRepresentation *representation = [result defaultRepresentation];
                NSURL *url = [representation url];  // Unique URL
                AVAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
                
                // Generate thumbnail image from video
                AVAssetImageGenerator *imageGenerator = [AVAssetImageGenerator assetImageGeneratorWithAsset:avAsset];
                imageGenerator.appliesPreferredTrackTransform = YES;
                imageGenerator.maximumSize = CGSizeMake(320, 180);
                
                // Set the timeframe between each part of the asset and return a thumbnail image for the asset at or near a specified time.
                CMTime thumbnailTime = CMTimeMakeWithSeconds(5, 35);
                CMTime actualTime;
                NSError *error;
                
                CGImageRef image = [imageGenerator copyCGImageAtTime:thumbnailTime actualTime:&actualTime error:&error];
                UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
                
                // Setup Video class
                Video *video = [[Video alloc]init];
                [video setThumbnailImage:thumb];
                [video setUniqueURL:url];
                
                [self.videoArray addObject:video];
                
                dispatch_async(dispatch_get_main_queue(), ^{  // Have the UI update itself in the main queue
                    [self.collectionView reloadData];
                });
            }else{
                NSLog(@"There are no videos anywhere. No bueno.");
            }
        }
    };
    
    // This block will enumerate the results of the enumerateGroupsWithTypes method. The results will be all groups in Photos and Library
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            // Filter for the group to enumerate only videos.
            [group setAssetsFilter:[ALAssetsFilter allVideos]];
            
            NSLog(@"%@", group.description);
            
            // Execute block
            @try {
                [group enumerateAssetsUsingBlock:enumBlock];
            }
            @catch (NSException *exception) {
                NSLog(@"Something unknown happened here: %@", exception);
            }
        }else{// If group is nil, we're done enumerating
            // e.g. if you're using a UICollectionView reload it here
            [self.collectionView reloadData];
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failBlock = ^(NSError *error) {
        NSLog(@"Authorization Denied: %@\n", error);
    };
    
    // Execute task which will all videos saved in your phone or synced with iTunes.
    [self.myAssetLibrary enumerateGroupsWithTypes:(ALAssetsGroupSavedPhotos | ALAssetsGroupLibrary) usingBlock:listGroupBlock failureBlock:failBlock];
    
    [self.collectionView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Data Source Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.videoArray.count > 0) {
        return self.videoArray.count;
    }
    return 0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VideoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell prepareForReuse];
    
    Video *currentVideo = [self.videoArray objectAtIndex:indexPath.row];
    [cell.videoThumbImageview setImage:currentVideo.thumbnailImage];
    
    return cell;
}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    VideoCollectionViewCell *currentcell = (VideoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    return [currentcell intrinsicContentSize];
//}

#pragma mark - UICollectionView Delegate Methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UICollectionViewCell class]]) {
        NSIndexPath *indexPath = [_collectionView indexPathForCell:sender];
        Video *video = [self.videoArray objectAtIndex:indexPath.row];
        PlayViewController *videoPlayerController = segue.destinationViewController;
        videoPlayerController.selectedVideo = video;
    }
}

@end

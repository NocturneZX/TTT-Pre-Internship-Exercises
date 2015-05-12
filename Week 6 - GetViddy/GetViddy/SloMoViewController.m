//
//  SloMoViewController.m
//  GetViddy
//
//  Created by Julio Reyes on 5/8/15.
//  Copyright (c) 2015 Julio Reyes. All rights reserved.
//

#import "SloMoViewController.h"

@interface SloMoViewController ()<UIAlertViewDelegate>
{
    NSTimeInterval startTime;
    BOOL isNeededToSave;
    CGFloat desiredFPS;
}

@property (nonatomic, strong) AVCaptureManager *captureManager;
@property (nonatomic, strong) NSURL *recordedURL;
@property (nonatomic, assign) NSTimer *timer;
@property (nonatomic, weak) IBOutlet UILabel *timeLabel;

@end

@implementation SloMoViewController

- (void)viewDidLoad {    desiredFPS = 120.0;

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.captureManager = [[AVCaptureManager alloc] initWithPreviewView:self.view];
    self.captureManager.delegate = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [self.captureManager switchFormatWithDesiredFPS:desiredFPS];
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - AVCaptureManagerDeleagte

- (void)didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL error:(NSError *)error {
    
    if (error) {
        NSLog(@"error:%@", error);
        return;
    }
    
    if (!isNeededToSave) {
        return;
    }
    
    _recordedURL = outputFileURL;
    [[[UIAlertView alloc]initWithTitle:@"Save?" message:@"Do you wish to save this video?" delegate:self cancelButtonTitle:@"NO!" otherButtonTitles:@"Yes", nil] show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"Cancelled.");
        self.timeLabel.text = @"00:00:00"; // Reset timer.
    }else{
        [self saveRecordedFile:_recordedURL];
    }
}

- (void)saveRecordedFile:(NSURL *)recordedFile {
    NSLog(@"%@", recordedFile);
    [SVProgressHUD showWithStatus:@"Saving..."
                         maskType:SVProgressHUDMaskTypeGradient];
    
    // THe block will update the UI and handle the changes in the collection view.
    ALAssetsLibraryWriteVideoCompletionBlock writeVideoBlock = ^(NSURL *assetURL, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [SVProgressHUD dismiss];
            
            NSString *title;
            NSString *message;
            
            if (error != nil) {
                
                title = @"Failed to save video";
                message = [error localizedDescription];
            }
            else {
                title = @"Your video is saved!";
                message = nil;
            }
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        });
    };
    
    // Save the video asynchrnously
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Save the video to the phone
        ALAssetsLibrary *assetLibrary = [[ALAssetsLibrary alloc] init];
        [assetLibrary writeVideoAtPathToSavedPhotosAlbum:recordedFile
                                         completionBlock:writeVideoBlock];
    });
}

#pragma mark - IBAction

- (IBAction)Record:(id)sender {
    
    // REC START
    if (!self.captureManager.isRecording) {
        self.timeLabel.textColor = [UIColor redColor];
        NSURL *path = [NSURL URLWithString:@"/System/Library/Audio/UISounds/begin_video_record.caf"]; // see list below
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)path, &soundID);
        AudioServicesPlaySystemSound(soundID);
        AudioServicesDisposeSystemSoundID(soundID);
        
        // timer start
        startTime = [[NSDate date] timeIntervalSince1970];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                      target:self
                                                    selector:@selector(timerHandler:)
                                                    userInfo:nil
                                                     repeats:YES];
        
        [self.captureManager startRecording];
    }
    // REC STOP
    else {
        
        NSURL *path = [NSURL URLWithString:@"/System/Library/Audio/UISounds/end_video_record.caf"]; // see list below
        SystemSoundID soundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)path, &soundID);
        AudioServicesPlaySystemSound(soundID);
        AudioServicesDisposeSystemSoundID(soundID);
        
        isNeededToSave = YES;
        [self.captureManager stopRecording];
        
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(IBAction)CloseRecorder:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
        isNeededToSave = NO;
        [self.captureManager stopRecording];
        
        [self.timer invalidate];
        self.timer = nil;
        
        self.captureManager = nil;
    }];
}
#pragma mark - Timer Handler

- (void)timerHandler:(NSTimer *)timer {
    
    NSTimeInterval current = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval recorded = current - startTime;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%.2f", recorded];
}

@end

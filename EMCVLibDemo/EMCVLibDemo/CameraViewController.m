//
//  CameraViewController.m
//  EMCVLibDemo
//
//  Created by 郑宇琦 on 2017/4/12.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "CameraViewController.h"
#import "EMCVLib/EMCVLib.h"
#import "opencv_c.h"

@interface CameraViewController ()

@property (weak) IBOutlet NSImageView *videoImageView;
@property (weak) IBOutlet NSImageView *imageView;
@property (weak) IBOutlet NSImageView *resultImageView;

@property (weak) IBOutlet NSImageView *subVideoImageView;
@property (weak) IBOutlet NSImageView *subImageView;
@property (weak) IBOutlet NSImageView *subResultImageView;
@property (weak) IBOutlet NSButton *videoBtn;
@property (weak) IBOutlet NSButton *cameraBtn;

@property (weak) IBOutlet NSTextField *fpsLabel;

@property (nonatomic) EMCVImage * curImage;
@property (nonatomic) EMCVImage * curVideoImage;
@property (nonatomic) EMCVImage * curResultImage;

@property (nonatomic) EMCVVideo * curVideo;

@property (nonatomic) dispatch_queue_t videoQueue;
@property (nonatomic) BOOL stopFlag;
@property (nonatomic) BOOL exitFlag;
@property (nonatomic) int fpsCounter;

@end

@implementation CameraViewController

- (void)setCurImage:(EMCVImage *)curImage {
    _curImage = curImage;
    [self setImage:curImage view:self.imageView subView:self.subImageView];
}

- (void)setCurVideoImage:(EMCVImage *)curVideoImage {
    _curVideoImage = curVideoImage;
    [self setImage:curVideoImage view:self.videoImageView subView:self.subVideoImageView];
}

- (void)setCurResultImage:(EMCVImage *)curResultImage {
    _curResultImage = curResultImage;
    [self setImage:curResultImage view:self.resultImageView subView:self.subResultImageView];
}

- (void)setImage:(EMCVImage *)img view:(NSImageView *)view subView:(NSImageView *)subView {
    if (img != nil) {
        [view drawCVImage:img];
        [subView drawRGBHistWithCVImage:img size:128];
    } else {
        [view setImage:nil];
        [subView setImage:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _exitFlag = false;
    _fpsCounter = 0;
    _stopFlag = true;
    _videoQueue = dispatch_queue_create("video", DISPATCH_QUEUE_SERIAL);
    dispatch_async(dispatch_queue_create("fps", DISPATCH_QUEUE_SERIAL), ^{
        while (!_exitFlag) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.fpsLabel.stringValue = [NSString stringWithFormat:@"%d fps", self.fpsCounter];
            });
            self.fpsCounter = 0;
            [NSThread sleepForTimeInterval:1];
        }
    });
}

- (void)viewDidDisappear {
    _exitFlag = true;
}

- (IBAction)showVideo:(id)sender {
    NSOpenPanel * panel = [[NSOpenPanel alloc] init];
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger ret){
        if (ret == 1) {
            self.videoBtn.enabled = false;
            self.cameraBtn.enabled = false;
            NSURL * url = panel.URLs[0];
            NSString * path = [url.absoluteString substringFromIndex:7];
            self.stopFlag = false;
            self.curVideo = [[EMCVVideo alloc] initWithPath:path];
            dispatch_async(_videoQueue, ^{
                EMCVImage * frame;
                while (!self.stopFlag && !self.exitFlag) {
                    @autoreleasepool {
                        frame = [self.curVideo nextFrame];
                        [frame cvtColor:CV_BGR2RGB];
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            self.curVideoImage = frame;
                        });
                        self.fpsCounter++;
                    }
                }
                self.curVideo = nil;
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.videoBtn.enabled = true;
                    self.cameraBtn.enabled = true;
                });
            });
        }
    }];
}

- (IBAction)showCamera:(id)sender {
    self.stopFlag = false;
    self.videoBtn.enabled = false;
    self.cameraBtn.enabled = false;
    self.curVideo = [[EMCVVideo alloc] initWithDevice:0];
    dispatch_async(_videoQueue, ^{
        EMCVImage * frame;
        while (!self.stopFlag && !self.exitFlag) {
            @autoreleasepool {
                frame = [self.curVideo nextFrame];
//                [frame pyrDownWithRatio:0.5];
                [frame cvtColor:CV_BGR2RGB];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.curVideoImage = frame;
                });
                self.fpsCounter++;
            }
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            self.curVideo = nil;
            self.videoBtn.enabled = true;
            self.cameraBtn.enabled = true;
        });
    });
}

- (IBAction)stop:(id)sender {
    self.stopFlag = true;
}

- (IBAction)showImage:(id)sender {
    NSOpenPanel * panel = [[NSOpenPanel alloc] init];
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger ret){
        if (ret == 1) {
            NSURL * url = panel.URLs[0];
            NSString * path = [url.absoluteString substringFromIndex:7];
            EMCVImage * img = [[EMCVImage alloc] initWithPath:path];
            [img cvtColor:CV_BGR2RGB];
            self.curImage = img;
        }
    }];
}

@end

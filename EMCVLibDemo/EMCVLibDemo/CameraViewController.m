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
@property (nonatomic) EMCVBasicImage * opticalFlowImageA;
@property (nonatomic) EMCVBasicImage * opticalFlowImageB;

@property (nonatomic) EMCVVideo * curVideo;
@property (nonatomic) EMCVFilter * curFilter;

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
        EMCVImage * displayImg = [img makeACopy];
        [self.curFilter runFilterWithImage:displayImg];
        [view drawCVImage:displayImg];
        [subView drawRGBHistWithCVImage:displayImg size:128];
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
    _curFilter = [[EMCVFilter alloc] init];
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
                    self.opticalFlowImageB = self.opticalFlowImageA;
                    self.opticalFlowImageA = self.curVideoImage;
                    self.curVideoImage = frame;
                });
                self.fpsCounter++;
            }
        }
        self.opticalFlowImageA = nil;
        self.opticalFlowImageB = nil;
        self.curVideo = nil;
        dispatch_sync(dispatch_get_main_queue(), ^{
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

- (IBAction)opticalFlow:(id)sender {
    [self.curFilter pushOperationBlock:^void(EMCVBasicImage * img) {
        if (self.opticalFlowImageA == nil || self.opticalFlowImageB == nil) {
            return;
        }
        EMCVSingleImage * imgA = [[self.opticalFlowImageA splitImage] imageAtChannal:0];
        EMCVSingleImage * imgB = [[self.opticalFlowImageB splitImage] imageAtChannal:0];
        NSArray<NSArray<NSValue *> *> * ret = [EMCVFactory calOpticalFlowPyrLKWithImage:imgA andImage:imgB useMaxCorners:500 andQLevel:0.01 andMinDistance:10];
        for (NSArray<NSValue *> * pointList in ret) {
            NSPoint p1 = pointList[0].pointValue;
            NSPoint p2 = pointList[1].pointValue;
            [img drawACircleWithCenter:p1 andRadius:5 andColor:kEMCVLibColorRed andThickness:2];
            [img drawACircleWithCenter:p2 andRadius:5 andColor:kEMCVLibColorRed andThickness:2];
            [img drawALineWithPoint:p1 andPoint:p2 andColor:kEMCVLibColorRed andThickness:2];
        }
        
    }];
}

@end

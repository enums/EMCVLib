//
//  OneViewController.m
//  EMCVLibDemo
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "OneViewController.h"
#import "opencv_c.h"
#import <EMCVLib/EMCVLib.h>

@interface OneViewController ()

@property (weak) IBOutlet NSImageView *imageView;
@property (weak) IBOutlet NSImageView *subImageView;
@property (weak) IBOutlet NSTextField *fpsLabel;
@property (weak) IBOutlet NSButton *videoBtn;

@property (nonatomic) EMCVImage * curImage;
@property (nonatomic) EMCVVideo * curVideo;

@property (nonatomic) EMCVFilter * curFilter;

@property (nonatomic) dispatch_queue_t videoQueue;
@property (nonatomic) BOOL stopFlag;
@property (nonatomic) BOOL exitFlag;
@property (nonatomic) int fpsCounter;

@end

@implementation OneViewController

- (void)setCurImage:(EMCVImage *)curImage {
    _curImage = curImage;
    if (curImage != nil) {
        EMCVImage * displayImg = [curImage makeACopy];
        [self.curFilter runFilterWithCVImage:displayImg];
        EMCVSplitedImage * splitedImage = [displayImg splitImage];
        NSPoint rPoint, gPoint, bPoint;
        [[splitedImage imageAtChannal:0] findMaxValue:nil outPoint:&rPoint];
        [displayImg drawACircleWithCenter:rPoint andRadius:25 andColor:kEMCVLibColorRed andThickness:2];
        if (splitedImage.channalCount >= 3) {
            [[splitedImage imageAtChannal:1] findMaxValue:nil outPoint:&gPoint];
            [[splitedImage imageAtChannal:2] findMaxValue:nil outPoint:&bPoint];
            [displayImg drawACircleWithCenter:gPoint andRadius:25 andColor:kEMCVLibColorGreen andThickness:2];
            [displayImg drawACircleWithCenter:bPoint andRadius:25 andColor:kEMCVLibColorBlue andThickness:2];
            [self.subImageView drawRGBHistWithCVImage:displayImg size:128];
        } else {
            [displayImg calHistWithSize:128 range:kEMCVLibRangeDefault];
            [displayImg normalizeHistWithValue:128];
            [self.subImageView drawHistWithCVImage:displayImg size:128 rgbColor:kEMCVLibColorWhite];
        }
        [self.imageView drawCVImage:displayImg];
        
    } else {
        [self.imageView setImage:nil];
        [self.subImageView setImage:nil];
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

- (IBAction)cleanImage:(id)sender {
    self.curImage = nil;
    [self.curFilter popAll];
}

- (IBAction)showVideo:(id)sender {
    NSOpenPanel * panel = [[NSOpenPanel alloc] init];
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger ret){
        if (ret == 1) {
            self.videoBtn.enabled = false;
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
                            self.curImage = frame;
                        });
                        self.fpsCounter++;
                    }
                }
                self.curVideo = nil;
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.videoBtn.enabled = true;
                });
            });
        }
    }];
}

- (IBAction)stopVideo:(id)sender {
    self.stopFlag = true;
}

- (IBAction)smooth:(id)sender {
    [self.curFilter pushOperationBlock:^void(EMCVImage * img) {
        [img gaussianBlurWithSize:NSMakeSize(7, 7)];
    }];
    [self setCurImage:self.curImage];
}

- (IBAction)lightness:(id)sender {
    [self.curFilter pushOperationBlock:^void(EMCVImage * img) {
        [img setBrightness:10];
    }];
    [self setCurImage:self.curImage];
}

- (IBAction)flipX:(id)sender {
    [self.curFilter pushOperationBlock:^void(EMCVImage * img) {
        [img flipWithXAxis];
    }];
    [self setCurImage:self.curImage];
}

- (IBAction)flipY:(id)sender {
    [self.curFilter pushOperationBlock:^void(EMCVImage * img) {
        [img flipWithYAxis];
    }];
    [self setCurImage:self.curImage];
}

- (IBAction)cornerHarris:(id)sender {
    EMCVSplitedImage * splitedImg = [self.curImage splitImage];
    EMCVSingleImage * singleImg = [[splitedImg imageAtChannal:0] newCornerHarrisWithBlockSize:2 andKSize:3 andK:0.04];
    [singleImg normalizeImageWithValue:255];
    [singleImg convertScaleAbs];
    EMCVImage * img = [[EMCVImage alloc] initWithCVSingleImage:singleImg];
    NSMutableArray<NSValue *> * arr = [[NSMutableArray alloc] init];
    [img forEachPixelWithBlock:^void(int x, int y, unsigned char * ptr) {
        if (*ptr > 150) {
            NSValue * value = [NSValue valueWithPoint:NSMakePoint(x, y)];
            [arr addObject:value];
        }
    }];
    for (NSValue * value in arr) {
        NSPoint point = value.pointValue;
        [img drawACircleWithCenter:point andRadius:10 andColor:kEMCVLibColorBlack andThickness:2];
    }
    [self setCurImage:img];
}

@end

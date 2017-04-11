//
//  MultiViewController.m
//  EMCVLibDemo
//
//  Created by 郑宇琦 on 2017/4/11.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import "MultiViewController.h"
#import "opencv_c.h"
#import "EMCVLib/EMCVLib.h"

@interface MultiViewController ()

@property (weak) IBOutlet NSImageView *imageViewA;
@property (weak) IBOutlet NSImageView *imageViewB;
@property (weak) IBOutlet NSImageView *imageViewC;

@property (weak) IBOutlet NSImageView *subImageViewA;
@property (weak) IBOutlet NSImageView *subImageViewB;
@property (weak) IBOutlet NSImageView *subImageViewC;

@property (nonatomic) EMCVImage * curImageA;
@property (nonatomic) EMCVImage * curImageB;
@property (nonatomic) EMCVImage * curImageC;

@end

@implementation MultiViewController

- (void)setCurImageA:(EMCVImage *)curImageA {
    _curImageA = curImageA;
    [self setImage:curImageA view:_imageViewA subView:_subImageViewA];
}

- (void)setCurImageB:(EMCVImage *)curImageB {
    _curImageB = curImageB;
    [self setImage:curImageB view:_imageViewB subView:_subImageViewB];
}

- (void)setCurImageC:(EMCVImage *)curImageC {
    _curImageC = curImageC;
    [self setImage:curImageC view:_imageViewC subView:_subImageViewC];
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
    // Do view setup here.
}

- (IBAction)showImageA:(id)sender {
    NSOpenPanel * panel = [[NSOpenPanel alloc] init];
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger ret){
        if (ret == 1) {
            NSURL * url = panel.URLs[0];
            NSString * path = [url.absoluteString substringFromIndex:7];
            EMCVImage * img = [[EMCVImage alloc] initWithPath:path];
            [img cvtColor:CV_BGR2RGB];
            self.curImageA = img;
        }
    }];
}

- (IBAction)showImageB:(id)sender {
    NSOpenPanel * panel = [[NSOpenPanel alloc] init];
    [panel beginSheetModalForWindow:self.view.window completionHandler:^(NSInteger ret){
        if (ret == 1) {
            NSURL * url = panel.URLs[0];
            NSString * path = [url.absoluteString substringFromIndex:7];
            EMCVImage * img = [[EMCVImage alloc] initWithPath:path];
            [img cvtColor:CV_BGR2RGB];
            self.curImageB = img;
        }
    }];
}

- (IBAction)compareHist:(id)sender {
    [self.curImageA calHistWithDims:3 size:128 range:kEMCVLibRangeDefault];
    [self.curImageB calHistWithDims:3 size:128 range:kEMCVLibRangeDefault];
    double currel = [EMCV compareHistWithCVImage:self.curImageA andImage:self.curImageB withMethod:CV_COMP_CORREL];
    double chisqr = [EMCV compareHistWithCVImage:self.curImageA andImage:self.curImageB withMethod:CV_COMP_CHISQR];
    double intersect = [EMCV compareHistWithCVImage:self.curImageA andImage:self.curImageB withMethod:CV_COMP_INTERSECT];
    double bhattachayya = [EMCV compareHistWithCVImage:self.curImageA andImage:self.curImageB withMethod:CV_COMP_BHATTACHARYYA];
    printf("currel(1~-1): %f\nchisqu(0~∞): %f\nintersect(↑): %f\nbhattachayya(0~1): %f\n\n", currel, chisqr, intersect, bhattachayya);
}

@end

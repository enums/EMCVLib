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

@property (weak) IBOutlet NSTextField *sizeField;

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
        if (img.channalCount == 3) {
            [subView drawRGBHistWithCVImage:img size:128];
        } else {
            [img calHistWithSize:128 range:kEMCVLibRangeDefault];
            [img normalizeHistWithValue:128];
            [subView drawHistWithCVImage:img size:128 rgbColor:kEMCVLibColorWhite];
        }
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

- (IBAction)blending:(id)sender {
    EMCVImage * img = [EMCVFactory blendingImage:self.curImageA withImage:self.curImageB useAlpha1:0.5 andAlpha2:0.5 andGama:0];
    self.curImageC = img;
}

- (IBAction)compareHist:(id)sender {
    [self.curImageA calHistWithDims:3 size:128 range:kEMCVLibRangeDefault];
    [self.curImageB calHistWithDims:3 size:128 range:kEMCVLibRangeDefault];
    double currel = [EMCVFactory compareHistWithCVImage:self.curImageA andImage:self.curImageB withMethod:CV_COMP_CORREL];
    double chisqr = [EMCVFactory compareHistWithCVImage:self.curImageA andImage:self.curImageB withMethod:CV_COMP_CHISQR];
    double intersect = [EMCVFactory compareHistWithCVImage:self.curImageA andImage:self.curImageB withMethod:CV_COMP_INTERSECT];
    double bhattachayya = [EMCVFactory compareHistWithCVImage:self.curImageA andImage:self.curImageB withMethod:CV_COMP_BHATTACHARYYA];
    printf("currel(1~-1): %f\nchisqu(0~∞): %f\nintersect(↑): %f\nbhattachayya(0~1): %f\n\n", currel, chisqr, intersect, bhattachayya);
}

- (IBAction)matchTemplate:(id)sender {
    EMCVImage * img = [EMCVFactory matchTemplateWithImage:self.curImageA andTempl:self.curImageB withMethod:CV_TM_SQDIFF_NORMED];
    EMCVSplitedImage * splitedImg = [img splitImage];
    NSPoint maxPoint;
    [[splitedImg imageAtChannal:0] findMinValue:nil outPoint:&maxPoint];
    NSSize templSize = self.curImageB.imageSize;
    maxPoint = NSMakePoint(maxPoint.x + templSize.width / 2, maxPoint.y + templSize.height / 2);
    EMCVImage * result = [self.curImageA makeACopy];
    [result drawARectWithCenter:maxPoint size:templSize rgbColor:kEMCVLibColorRed thickness:2];
    self.curImageC = result;
}

- (IBAction)doBackProjection:(id)sender {
    int size = self.sizeField.intValue;
    [self.curImageA calHistWithSize:size range:kEMCVLibRangeDefault];
    [self.curImageB calHistWithSize:size range:kEMCVLibRangeDefault];
    EMCVImage * img = [EMCVFactory doBackProjectionWithImage:self.curImageA andTempl:self.curImageB withDims:3];
    self.curImageC = img;
}

- (IBAction)contours:(id)sender {
    double tresh = self.sizeField.doubleValue;
    EMCVImage * img = [[EMCVImage alloc] init];
    [self.curImageA cannyOnCVImage:img withThresh1:tresh andThreash2:tresh * 2];
    self.curImageC = img;
}

- (IBAction)threshold:(id)sender {
    double threshold = self.sizeField.doubleValue;
    EMCVSplitedImage * img = [self.curImageA splitImage];
    EMCVSingleImage * singleImg = [img imageAtChannal:0];
    [singleImg threshold:threshold];
    self.curImageC = [[EMCVImage alloc] initWithCVSingleImage:[img imageAtChannal:0]];
}

@end

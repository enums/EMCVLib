//
//  NSImageView+EMCVLib.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "EMCVImage.h"
#ifdef __cplusplus
#import "opencv.h"
using namespace cv;
#endif

@interface NSImageView (EMCVLib)

#ifdef __cplusplus
- (void)drawHistOnMat:(Mat)mat withHist:(MatND)hist size:(int)size color:(Scalar)color;
#endif

- (void)drawCVImage:(EMCVImage *)cvImg;
- (void)drawAndFitSizeWithCVImage:(EMCVImage *)cvImg;

- (void)setImageAndFitSizeWithImage:(NSImage *)img;

- (void)drawRGBHistWithCVImage:(EMCVImage *)cvImg size:(int)size;
- (void)drawHistWithCVImage:(EMCVImage *)cvImg size:(int)size rgbColor:(int *)rgb;
- (void)drawHistWithCVSplitedImage:(EMCVSplitedImage *)splitedImg sizes:(int *)sizes rgbColors:(int **)rgbs;
- (void)drawHistWithCVSplitedImage:(EMCVSplitedImage *)splitedImg channal:(int)channal size:(int)size rgbColor:(int *)rgb;

@end

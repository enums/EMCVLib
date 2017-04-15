//
//  EMCVImage.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "platform.h"
#import "EMCVSplitedImage.h"
#import "EMCVSingleImage.h"

@class EMCVSingleImage;
@class EMCVSplitedImage;

#ifdef __cplusplus
#include "opencv.h"
using namespace cv;
#endif

@interface EMCVImage : NSObject

#ifdef __cplusplus
{
@public
    Mat _mat;
    MatND _hist;
}
- (instancetype)initWithMat:(Mat)mat;
- (instancetype)initWithMat:(Mat)mat cvtColor:(int)color;
- (instancetype)initWithNoCopyMat:(Mat)mat;
#endif

@property (nonatomic, readonly) NSUInteger channalCount;
@property (nonatomic, readonly) NSSize imageSize;

- (instancetype)initWithPath:(NSString *)path;
- (instancetype)initWithSize:(NSSize)size andType:(int)type andColor:(int *)color;
- (instancetype)initWithCVImage:(EMCVImage *)img;
- (instancetype)initWithCVImage:(EMCVImage *)img cvtColor:(int)color;
- (instancetype)initWithCVSplitedImage:(EMCVSplitedImage *)splitedImage;
- (instancetype)initWithCVSingleImage:(EMCVSingleImage *)singleImage;

- (EMCVImage *)makeACopy;

- (EMCVSplitedImage *)splitImage;
- (void)drawALineWithPoint:(NSPoint)p1 andPoint:(NSPoint)p2 andColor:(int *)rgb andThickness:(int)thickness;
- (void)drawARectWithCenter:(NSPoint)center size:(NSSize)size rgbColor:(int *)rgb thickness:(int)thickness;
- (void)drawARect:(NSRect)rect rgbColor:(int *)rgb thickness:(int)thickness;
- (void)drawACircleWithCenter:(NSPoint)center andRadius:(int)radius andColor:(int *)rgb andThickness:(int)thickness;
- (void)cvtColor:(int)code;
- (void)flipWithXAxis;
- (void)flipWithYAxis;
- (void)setBrightness:(int)brightness;
- (void)pyrUpWithRatio:(double)ratio;
- (void)pyrDownWithRatio:(double)ratio;
- (void)blurWithSize:(NSSize)size;
- (void)medianBlurWithSize:(int)size;
- (void)bilateralFilterWithDelta:(int)d andSigmaColor:(double)sc andSigmaSpace:(double)sp;
- (void)gaussianBlurWithSize:(NSSize)size;
- (EMCVImage *)newCannyWithThresh1:(double)thresh1 andThresh2:(double)thresh2;
- (void)cannyOnCVImage:(EMCVImage *)img withThresh1:(double)thresh1 andThreash2:(double)thresh2;

- (void)calHistWithSize:(int)size range:(float *)range;
- (void)calHistWithDims:(int)dims size:(int)size range:(float *)range;
- (void)calHistWithDims:(int)dims sizes:(int *)sizes ranges:(float **)ranges;

- (void)normalizeImageWithValue:(double)value;
- (void)normalizeHistWithValue:(double)value;

#if TARGET_OS_IPHONE
- (instancetype)initWithImage:(UIImage *)img;
- (UIImage *)toImage;
#elif TARGET_OS_MAC
- (NSImage *)toImage;
#endif

@end


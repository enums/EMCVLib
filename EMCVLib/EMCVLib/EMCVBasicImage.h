//
//  EMCVBasicImage.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/17.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "platform.h"

#ifdef __cplusplus
#include "opencv.h"
using namespace cv;
#endif

@interface EMCVBasicImage : NSObject
#ifdef __cplusplus
{
@public
    Mat _mat;
    MatND _hist;
}
- (instancetype)initWithMat:(Mat)mat;
- (instancetype)initWithNoCopyMat:(Mat)mat;
- (instancetype)initWithMat:(Mat)mat cvtColor:(int)color;
#endif
@property (nonatomic, readonly) NSUInteger channalCount;
@property (nonatomic, readonly) NSSize imageSize;

- (instancetype)initWithSize:(NSSize)size andType:(int)type andColor:(int *)color;

- (void)cvtColor:(int)code;

- (void)forEachPixelWithBlock:(void(^)(int, int, unsigned char *))block;
- (void)forEachPixelAtX:(int)x andY:(int)y withBlock:(void(^)(int, int, unsigned char *))block;

- (void)flipWithXAxis;
- (void)flipWithYAxis;

- (void)setBrightness:(double)brightness;
- (void)drawALineWithPoint:(NSPoint)p1 andPoint:(NSPoint)p2 andColor:(int *)rgb andThickness:(int)thickness;
- (void)drawARectWithCenter:(NSPoint)center size:(NSSize)size rgbColor:(int *)rgb thickness:(int)thickness;
- (void)drawARect:(NSRect)rect rgbColor:(int *)rgb thickness:(int)thickness;
- (void)drawACircleWithCenter:(NSPoint)center andRadius:(int)radius andColor:(int *)rgb andThickness:(int)thickness;

- (void)blurWithSize:(NSSize)size;
- (void)medianBlurWithSize:(int)size;
- (void)bilateralFilterWithDelta:(int)d andSigmaColor:(double)sc andSigmaSpace:(double)sp;
- (void)gaussianBlurWithSize:(NSSize)size;

- (void)pyrUpWithRatio:(double)ratio;
- (void)pyrDownWithRatio:(double)ratio;

- (void)normalizeImageWithValue:(double)value;
- (void)normalizeHistWithValue:(double)value;

- (void)calHistWithSize:(int)size;
- (void)calHistWithSize:(int)size range:(float *)range;
- (void)calHistWithSizes:(int *)sizes ranges:(float **)ranges;



#if TARGET_OS_IPHONE
- (instancetype)initWithImage:(UIImage *)img;
- (UIImage *)toImage;
#elif TARGET_OS_MAC
- (NSImage *)toImage;
#endif

@end

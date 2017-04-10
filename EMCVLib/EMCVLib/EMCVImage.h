//
//  EMCVImage.h
//  EMCVLib
//
//  Created by 郑宇琦 on 2017/4/10.
//  Copyright © 2017年 郑宇琦. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "EMCVSplitedImage.h"

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

- (instancetype)initWithPath:(NSString *)path;
- (instancetype)initWithCVImage:(EMCVImage *)img;
- (instancetype)initWithCVImage:(EMCVImage *)img cvtColor:(int)color;
- (instancetype)initWithSplitedImage:(EMCVSplitedImage *)splitedImage;

- (EMCVSplitedImage *)splitImage;
- (void)drawARectWithCenter:(NSPoint)center size:(NSSize)size rgbColor:(int *)rgb thickness:(int)thickness;
- (void)drawARect:(NSRect)rect rgbColor:(int *)rgb thickness:(int)thickness;
- (void)cvtColor:(int)code;
- (NSImage *)toImage;

- (void)calHistWithDims:(int)dims size:(int)size range:(float *)range;
- (void)calHistWithDims:(int)dims sizeList:(int *)sizes rangeList:(float **)ranges;
- (void)normalizeHistWithValue:(double)value;

@end

